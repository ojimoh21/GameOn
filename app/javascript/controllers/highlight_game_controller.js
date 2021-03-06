import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['game', "checkbox"]

  highlight(event) {
    if (event) {
      this.checkboxTarget.checked = !this.checkboxTarget.checked;
      this.gameTarget.classList.toggle("selected")
    }
  }
}
