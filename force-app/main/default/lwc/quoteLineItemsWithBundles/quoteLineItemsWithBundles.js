import { api, LightningElement } from "lwc";
import LightningConfirm from "lightning/confirm";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { RefreshEvent } from "lightning/refresh";
import deleteLine from "@salesforce/apex/QuoteLineItemsController.deleteLine";
import getContext from "@salesforce/apex/QuoteLineItemsController.getContext";

export default class QuoteLineItemsWithBundles extends LightningElement {
  _recordId;

  isLoading = false;
  hasLoaded = false;
  quoteName = "";
  quoteStatus = "";
  canDeleteLines = false;
  rows = [];
  deletingLineId = "";
  columns = [
    {
      label: "Prodotto",
      fieldName: "quoteLineUrl",
      type: "url",
      typeAttributes: {
        label: { fieldName: "productName" },
        target: "_blank"
      },
      initialWidth: 320
    },
    {
      label: "Codice",
      fieldName: "productCode",
      type: "text"
    },
    {
      label: "Qta",
      fieldName: "quantityLabel",
      type: "text"
    },
    {
      label: "Prezzo unitario",
      fieldName: "unitPriceLabel",
      type: "text"
    },
    {
      label: "Totale",
      fieldName: "totalPriceLabel",
      type: "text"
    },
    {
      type: "action",
      typeAttributes: {
        rowActions: { fieldName: "rowActions" }
      }
    }
  ];

  @api
  get recordId() {
    return this._recordId;
  }

  set recordId(value) {
    this._recordId = value;
    if (value) {
      this.loadContext();
    }
  }

  get showInitialLoader() {
    return !this.hasLoaded && this.isLoading;
  }

  get hasRows() {
    return this.rows.length > 0;
  }

  get treeRows() {
    const linesById = new Map();
    const parentRows = [];

    for (const row of this.rows) {
      if (row.isComponent) {
        continue;
      }

      const treeRow = this.decorateTreeRow(row);
      treeRow._children = [];
      linesById.set(row.id, treeRow);
      parentRows.push(treeRow);
    }

    for (const row of this.rows) {
      if (!row.isComponent) {
        continue;
      }

      const parent = linesById.get(row.parentLineId);
      if (parent) {
        parent._children.push(this.decorateTreeRow(row));
      }
    }

    return parentRows.map((row) => {
      if (!row._children.length) {
        const rowWithoutChildren = { ...row };
        delete rowWithoutChildren._children;
        return rowWithoutChildren;
      }
      return row;
    });
  }

  async loadContext() {
    this.isLoading = true;
    try {
      this.applyContext(await getContext({ quoteId: this.recordId }));
    } catch (error) {
      this.showToast("Errore", this.reduceError(error), "error");
    } finally {
      this.hasLoaded = true;
      this.isLoading = false;
    }
  }

  applyContext(context) {
    this.quoteName = context.quoteName || "";
    this.quoteStatus = context.quoteStatus || "";
    this.canDeleteLines = context.canDeleteLines === true;
    this.rows = context.rows || [];
  }

  handleRefresh() {
    this.loadContext();
  }

  handleRowAction(event) {
    if (event.detail.action.name === "delete") {
      this.deleteLine(event.detail.row);
    }
  }

  async deleteLine(selectedRow) {
    const lineId = selectedRow.id;
    if (!lineId || selectedRow.isComponent) {
      return;
    }

    const sourceRow = this.rows.find((entry) => entry.id === lineId);
    const confirmed = await LightningConfirm.open({
      label: "Elimina riga preventivo",
      message: `Eliminare ${
        sourceRow?.productName || "questa riga"
      } dal preventivo?`,
      variant: "headerless"
    });

    if (!confirmed) {
      return;
    }

    this.isLoading = true;
    this.deletingLineId = lineId;
    try {
      this.applyContext(
        await deleteLine({ quoteId: this.recordId, lineId: lineId })
      );
      this.showToast("Successo", "Riga preventivo eliminata.", "success");
      this.dispatchEvent(new RefreshEvent());
    } catch (error) {
      this.showToast("Errore", this.reduceError(error), "error");
    } finally {
      this.deletingLineId = "";
      this.isLoading = false;
    }
  }

  decorateTreeRow(row) {
    const quoteLineId = row.isComponent ? row.parentLineId : row.id;
    const lineUrl = quoteLineId
      ? `/lightning/r/QuoteLineItem/${quoteLineId}/view`
      : "";

    return {
      ...row,
      productName: row.productName || "Prodotto senza nome",
      productCode: row.productCode || "Nessun codice",
      quantityLabel: this.formatNumber(row.quantity),
      unitPriceLabel: this.formatAmount(row.unitPrice),
      totalPriceLabel: this.formatAmount(row.totalPrice),
      quoteLineUrl: lineUrl,
      rowActions: row.isComponent
        ? []
        : [
            {
              label: "Elimina riga",
              name: "delete",
              iconName: "utility:delete",
              disabled:
                row.deleteDisabled ||
                this.isLoading ||
                this.deletingLineId === row.id
            }
          ]
    };
  }

  formatAmount(value) {
    if (value === null || value === undefined) {
      return "-";
    }
    return new Intl.NumberFormat(undefined, {
      style: "currency",
      currency: "EUR"
    }).format(value);
  }

  formatNumber(value) {
    if (value === null || value === undefined) {
      return "-";
    }
    return new Intl.NumberFormat(undefined, {
      maximumFractionDigits: 2
    }).format(value);
  }

  showToast(title, message, variant) {
    this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
  }

  reduceError(error) {
    console.error("quoteLineItemsWithBundles error", error);

    if (!error) {
      return "Errore sconosciuto";
    }
    if (typeof error === "string") {
      return error;
    }

    const messages = [];
    const body = error.body ?? error;

    if (Array.isArray(body)) {
      messages.push(...body.map((entry) => entry?.message).filter(Boolean));
    }
    if (body?.message) {
      messages.push(body.message);
    }
    if (Array.isArray(body?.pageErrors)) {
      messages.push(
        ...body.pageErrors.map((entry) => entry?.message).filter(Boolean)
      );
    }
    if (body?.fieldErrors) {
      for (const field of Object.keys(body.fieldErrors)) {
        messages.push(
          ...body.fieldErrors[field]
            .map((entry) => entry?.message)
            .filter(Boolean)
        );
      }
    }
    if (body?.output?.errors?.length) {
      messages.push(
        ...body.output.errors.map((entry) => entry?.message).filter(Boolean)
      );
    }
    if (!messages.length && error.message) {
      messages.push(error.message);
    }

    return messages.length
      ? messages.join(" | ")
      : JSON.stringify(error).slice(0, 255);
  }
}
