import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.element.showModal();
  }

  close() {
    this.element.close();

    const frame = document.querySelector('turbo-frame#modal');
    if (frame) frame.innerHTML = "";
  }

  backdropClose(event) {
    if (event.target === this.element) this.close();
  }
}
