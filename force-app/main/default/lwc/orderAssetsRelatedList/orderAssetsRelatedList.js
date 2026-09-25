import { api, LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getAssets from "@salesforce/apex/OrderAssetsController.getAssets";

export default class OrderAssetsRelatedList extends LightningElement {
  _recordId;

  isLoading = false;
  hasLoaded = false;
  rows = [];
  columns = [
    {
      label: "Asset",
      fieldName: "assetUrl",
      type: "url",
      typeAttributes: {
        label: { fieldName: "name" },
        target: "_blank"
      },
      initialWidth: 220
    },
    {
      label: "Stato",
      fieldName: "status",
      type: "text"
    },
    {
      label: "Prodotto",
      fieldName: "productUrl",
      type: "url",
      typeAttributes: {
        label: { fieldName: "productLabel" },
        target: "_blank"
      },
      initialWidth: 260
    },
    {
      label: "Order Product",
      fieldName: "orderProductUrl",
      type: "url",
      typeAttributes: {
        label: { fieldName: "orderProductLabel" },
        target: "_blank"
      }
    },
    {
      label: "Campagna",
      fieldName: "campaignUrl",
      type: "url",
      typeAttributes: {
        label: { fieldName: "campaignLabel" },
        target: "_blank"
      },
      initialWidth: 220
    },
    {
      label: "Creato",
      fieldName: "createdDate",
      type: "date",
      typeAttributes: {
        day: "2-digit",
        month: "2-digit",
        year: "numeric",
        hour: "2-digit",
        minute: "2-digit"
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
      this.loadAssets();
    }
  }

  get title() {
    return `Asset ordine (${this.rows.length})`;
  }

  get showInitialLoader() {
    return !this.hasLoaded && this.isLoading;
  }

  get hasRows() {
    return this.rows.length > 0;
  }

  get displayRows() {
    return this.rows.map((row) => ({
      ...row,
      assetUrl: this.recordUrl("Asset", row.id),
      productUrl: this.recordUrl("Product2", row.productId),
      productLabel: this.productLabel(row),
      orderProductUrl: this.recordUrl("OrderItem", row.orderProductId),
      orderProductLabel: row.orderProductQuantity
        ? `Riga ordine x ${row.orderProductQuantity}`
        : "Riga ordine",
      campaignUrl: this.recordUrl("Campaign", row.campaignId),
      campaignLabel: row.campaignName || ""
    }));
  }

  async loadAssets() {
    this.isLoading = true;
    try {
      this.rows = await getAssets({ orderId: this.recordId });
    } catch (error) {
      this.showToast("Errore", this.reduceError(error), "error");
    } finally {
      this.hasLoaded = true;
      this.isLoading = false;
    }
  }

  handleRefresh() {
    this.loadAssets();
  }

  recordUrl(objectApiName, recordId) {
    return recordId ? `/lightning/r/${objectApiName}/${recordId}/view` : "";
  }

  productLabel(row) {
    if (row.productName && row.productCode) {
      return `${row.productName} (${row.productCode})`;
    }
    return row.productName || row.productCode || "";
  }

  showToast(title, message, variant) {
    this.dispatchEvent(
      new ShowToastEvent({
        title,
        message,
        variant
      })
    );
  }

  reduceError(error) {
    if (Array.isArray(error?.body)) {
      return error.body.map((entry) => entry.message).join(", ");
    }

    return error?.body?.message || error?.message || "Errore imprevisto.";
  }
}
