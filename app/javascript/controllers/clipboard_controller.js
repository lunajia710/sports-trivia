import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { text: String }
  static targets = ["button"]

  copy() {
    navigator.clipboard.writeText(this.textValue).then(() => {
      const btn = this.hasButtonTarget ? this.buttonTarget : this.element
      const original = btn.innerHTML
      btn.innerHTML = '<i class="fa-solid fa-check"></i> Copied!'
      setTimeout(() => { btn.innerHTML = original }, 2000)
    })
  }
}
