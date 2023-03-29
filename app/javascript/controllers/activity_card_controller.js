import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["title", "category", "public"];
  static values = { id: Number };

  connect() {
    this.idValue = this.data.get("activityId");
  }

  loadActivity() {
    fetch(`/activities/${this.idValue}.json`)
      .then((response) => response.json())
      .then((data) => {
        this.titleTarget.textContent = data.title;
        this.categoryTarget.textContent = data.category.name;
        this.publicTarget.textContent = data.public ? "Público" : "Privado";
      });
  }
}
