import { Controller } from "@hotwired/stimulus"
import confetti from "canvas-confetti"

export default class extends Controller {
  connect() {
    confetti({ particleCount: 150, spread: 70, origin: { y: 0.6 } })
  }
}
