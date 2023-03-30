import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="mask"
export default class extends Controller {
  static targets = ["input"];

  connect() {
    this.inputTarget.addEventListener("input", this.maskInput.bind(this));
  }

  maskInput() {
    let input = this.inputTarget.value.replace(/\D/g, "");
    if (this.inputTarget.id === "phone") {
      input = input.substring(0, 11);
      input = input.replace(/^(\d{2})(\d)/g, "($1) $2");
      input = input.replace(/(\d)(\d{4})$/, "$1-$2");
    } else if (this.inputTarget.id === "cpf") {
      input = input.substring(0, 11);
      input = input.replace(/^(\d{3})(\d)/g, "$1.$2");
      input = input.replace(/^(\d{3})\.(\d{3})(\d)/g, "$1.$2.$3");
      input = input.replace(
        /^(\d{3})\.(\d{3})\.(\d{3})(\d{1,2})/g,
        "$1.$2.$3-$4"
      );
    }
    this.inputTarget.value = input;
  }
}
