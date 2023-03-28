import { Controller } from "@hotwired/stimulus";
import _ from "lodash";
import $ from "jquery";

// Connects to data-controller="search"
export default class extends Controller {
  connect() {
    this.perform = _.debounce(this.perform, 500).bind(this);

    $("#profile-type-select").change(() => {
      this.element.requestSubmit();
    });
  }

  perform() {
    this.element.requestSubmit();
  }
}
