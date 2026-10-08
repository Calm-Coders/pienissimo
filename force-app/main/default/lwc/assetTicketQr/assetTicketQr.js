import { api, LightningElement } from "lwc";
import { loadScript } from "lightning/platformResourceLoader";
import { CloseActionScreenEvent } from "lightning/actions";
import qrGenerator from "@salesforce/resourceUrl/AssetQrGenerator";

export default class AssetTicketQr extends LightningElement {
  _recordId;

  @api
  set recordId(value) {
    this._recordId = value;
    this.qrId = value;
    this.renderQr();
  }

  get recordId() {
    return this._recordId;
  }

  qrId;
  qrImage;
  errorMessage;
  libraryReady = false;

  connectedCallback() {
    loadScript(this, qrGenerator)
      .then(() => {
        this.libraryReady = true;
        this.renderQr();
      })
      .catch(() => {
        this.errorMessage = "Impossibile caricare il generatore QR.";
      });
  }

  get hasQr() {
    return Boolean(this.qrImage);
  }

  get isLoading() {
    return !this.qrImage && !this.errorMessage && Boolean(this.qrId);
  }

  get emptyMessage() {
    return this.qrId ? "" : "Impossibile identificare il biglietto.";
  }

  renderQr() {
    if (!this.libraryReady || !this.qrId) {
      this.qrImage = undefined;
      return;
    }

    try {
      const qr = window.qrcode(0, "M");
      qr.addData(this.qrId, "Byte");
      qr.make();
      this.qrImage = qr.createDataURL(6, 24);
      this.errorMessage = undefined;
    } catch {
      this.qrImage = undefined;
      this.errorMessage = "Impossibile generare il codice QR.";
    }
  }

  handleClose() {
    this.dispatchEvent(new CloseActionScreenEvent());
  }
}
