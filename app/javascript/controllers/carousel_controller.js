import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card", "counter"]

  connect() { this.index = 0; this.show() }

  next() {
    this.index = (this.index + 1) % this.cardTargets.length
    this.show()
  }

  prev() {
    this.index = (this.index - 1 + this.cardTargets.length) % this.cardTargets.length
    this.show()
  }

  show() {
    this.cardTargets.forEach((card, i) => card.classList.toggle("d-none", i !== this.index))
    if (this.hasCounterTarget) {
      this.counterTarget.textContent = `${this.index + 1} / ${this.cardTargets.length}`
    }
  }
}
