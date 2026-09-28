#!/usr/bin/env python3
"""Install the reusable project-local meeting workflow into an existing SF project."""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

from create_sf_project import install_project_workflows, one_line


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--project-dir", required=True, help="Existing Salesforce project directory")
    parser.add_argument("--name", required=True, help="Human-readable project name")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    project_dir = Path(args.project_dir).expanduser().resolve()
    display_name = one_line(args.name)
    if not display_name:
        raise ValueError("Project name cannot be blank.")
    result = install_project_workflows(project_dir, display_name)
    print(json.dumps(result, indent=2))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (FileExistsError, RuntimeError, ValueError) as exc:
        print(f"error: {exc}", file=sys.stderr)
        raise SystemExit(1)
