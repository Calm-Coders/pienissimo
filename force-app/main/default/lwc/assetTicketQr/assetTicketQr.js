import { api, LightningElement, wire } from "lwc";
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import { loadScript } from "lightning/platformResourceLoader";
import { CloseActionScreenEvent } from "lightning/actions";
import qrGenerator from "@salesforce/resourceUrl/AssetQrGenerator";
import QR_ID_FIELD from "@salesforce/schema/Asset.QR_Id__c";

export default class AssetTicketQr extends LightningElement {
  @api recordId;

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

  @wire(getRecord, { recordId: "$recordId", fields: [QR_ID_FIELD] })
  wiredAsset({ data, error }) {
    if (data) {
      this.qrId = getFieldValue(data, QR_ID_FIELD);
      this.errorMessage = undefined;
      this.renderQr();
    } else if (error) {
      this.errorMessage = "Impossibile leggere il codice QR del biglietto.";
    }
  }

  get hasQr() {
    return Boolean(this.qrImage);
  }

  get isLoading() {
    return !this.qrImage && !this.errorMessage && Boolean(this.qrId);
  }

  get emptyMessage() {
    return this.qrId
      ? ""
      : "Assegna il biglietto a un contatto e a una campagna per generare il QR.";
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
