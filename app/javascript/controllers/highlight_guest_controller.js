import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['guest', "checkbox"]

  highlight(event) {
    if (event) {
      this.checkboxTarget.checked = !this.checkboxTarget.checked;
      this.guestTarget.classList.toggle("selected-guest")
    }
  }
}
