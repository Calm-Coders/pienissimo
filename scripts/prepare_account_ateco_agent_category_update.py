"""Prepare the UAT ATECO-state and agent-category backfill from Account_NEW.

Only Id and the requested target field are written to temporary CSV files.
The script reads Salesforce but does not submit any update jobs.
"""

from __future__ import annotations

import csv
import json
import shutil
import subprocess
import sys
import tempfile
from collections import Counter, defaultdict
from pathlib import Path

import openpyxl


ORG = "Pienissimo UAT"
SHEET = "Account_NEW"
EXPECTED_CATEGORY = {
    "Barbara Giordani": "4",
    "Carmen Troiano": "17",
    "Davide Stefani": "19",
    "Elisa Migliano": "",
    "Martina Pizzoni": "14",
    "Nicol Pironi": "19",  # Explicitly selected by the user for this ambiguous agent.
    "Sara Del Sordo": "10",
    "Segreteria Segreteria Pienissimo": "1",
    "Valentina Veronesi": "16",
}


def sf(*args: str) -> dict:
    executable = shutil.which("sf.cmd") or shutil.which("sf")
    if not executable:
        raise RuntimeError("Salesforce CLI was not found")
    result = subprocess.run(
        [executable, *args, "--target-org", ORG, "--json"],
        capture_output=True,
        text=True,
        check=False,
    )
    payload = json.loads(result.stdout)
    if result.returncode or payload.get("status") != 0:
        raise RuntimeError(payload.get("message", payload.get("name", result.stderr)))
    return payload["result"]


def query(soql: str) -> list[dict]:
    result = sf("data", "query", "--query", soql)
    if len(result["records"]) != result["totalSize"]:
        raise RuntimeError("SOQL result was incomplete")
    return result["records"]


def clean(value: object) -> str:
    return "" if value is None else str(value).strip()


def csv_file(path: Path, fields: list[str], rows: list[dict]) -> None:
    with path.open("w", encoding="utf-8", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit("usage: prepare_account_ateco_agent_category_update.py WORKBOOK.xlsx")
    workbook_path = Path(sys.argv[1]).resolve()
    if not workbook_path.is_file():
        raise RuntimeError("Source workbook is missing")
    if "sandbox.my.salesforce.com" not in sf("org", "display").get("instanceUrl", ""):
        raise RuntimeError("Refusing to prepare data for a non-sandbox org")

    workbook = openpyxl.load_workbook(workbook_path, read_only=True, data_only=True)
    sheet = workbook[SHEET]
    iterator = sheet.iter_rows(values_only=True)
    headers = next(iterator)
    columns = {clean(header): index for index, header in enumerate(headers)}
    required = {
        "CRM", "Partita Iva", "Azienda Proprietario Name",
        "Categoria Provvigioni Cliente", "Ateco Stato Attivita",
    }
    if not required.issubset(columns):
        raise RuntimeError("Account_NEW columns changed")

    source: dict[str, str] = {}
    categories: dict[str, Counter[str]] = defaultdict(Counter)
    for row in iterator:
        if not clean(row[columns["Partita Iva"]]):
            continue
        crm = clean(row[columns["CRM"]])
        agent = clean(row[columns["Azienda Proprietario Name"]])
        category = clean(row[columns["Categoria Provvigioni Cliente"]])
        state = clean(row[columns["Ateco Stato Attivita"]])
        if not crm or crm in source or agent not in EXPECTED_CATEGORY:
            raise RuntimeError("CRM key or agent changed in source")
        if state not in {"", "ATTIVA", "INATTIVA", "CESSATA"}:
            raise RuntimeError("Unexpected ATECO state")
        source[crm] = state
        categories[agent][category] += 1
    if len(source) != 8140 or sum(bool(value) for value in source.values()) != 377:
        raise RuntimeError("Eligible Account or ATECO-state counts changed")
    if set(categories) != set(EXPECTED_CATEGORY):
        raise RuntimeError("Agent names changed")
    for agent, category in EXPECTED_CATEGORY.items():
        if category and categories[agent][category] == 0:
            raise RuntimeError("Chosen agent category is absent from the source")
        if agent == "Elisa Migliano" and categories[agent] != Counter({"": 1}):
            raise RuntimeError("Elisa's source category changed")

    accounts = query(
        "SELECT Id, External_CRM_ID__c, Ateco_Stato_Attivita__c FROM Account "
        "WHERE External_CRM_ID__c != null"
    )
    if len(accounts) != 8140 or {a["External_CRM_ID__c"] for a in accounts} != set(source):
        raise RuntimeError("UAT Accounts do not match eligible source CRM IDs")
    account_rows = []
    for account in accounts:
        state = source[account["External_CRM_ID__c"]]
        current = clean(account["Ateco_Stato_Attivita__c"])
        if current and current != state:
            raise RuntimeError("Existing UAT ATECO state conflicts with the source")
        if state and current != state:
            account_rows.append({"Id": account["Id"], "Ateco_Stato_Attivita__c": state})
    if len(account_rows) != 377:
        raise RuntimeError("Expected exactly 377 new Account ATECO states")

    users = query(
        "SELECT Id, Name, IsActive, Categoria_Provvigioni_Cliente__c "
        "FROM User WHERE Profile.Name = 'Agente'"
    )
    if len(users) != 9 or {user["Name"] for user in users} != set(EXPECTED_CATEGORY):
        raise RuntimeError("UAT Agent users do not match the source")
    user_rows = []
    for user in users:
        if user["IsActive"]:
            raise RuntimeError("An Agent user is active")
        expected = EXPECTED_CATEGORY[user["Name"]]
        current = clean(user["Categoria_Provvigioni_Cliente__c"])
        if current and current != expected:
            raise RuntimeError("Existing Agent category conflicts with the source")
        if expected and current != expected:
            user_rows.append({"Id": user["Id"], "Categoria_Provvigioni_Cliente__c": expected})
    if len(user_rows) != 8:
        raise RuntimeError("Expected exactly eight Agent user updates")

    output = Path(tempfile.mkdtemp(prefix="pienissimo-ateco-agent-category-"))
    account_rows.sort(key=lambda item: item["Id"])
    user_rows.sort(key=lambda item: item["Id"])
    csv_file(output / "account_sample.csv", ["Id", "Ateco_Stato_Attivita__c"], account_rows[:1])
    csv_file(output / "account_remaining.csv", ["Id", "Ateco_Stato_Attivita__c"], account_rows[1:])
    csv_file(output / "users.csv", ["Id", "Categoria_Provvigioni_Cliente__c"], user_rows)
    print(json.dumps({"output": str(output), "accounts": len(account_rows), "users": len(user_rows)}))


if __name__ == "__main__":
    main()
