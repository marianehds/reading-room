import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  close() {
    const frame = document.querySelector('turbo-frame#modal');
    if (frame) frame.innerHTML = "";
  }
}
