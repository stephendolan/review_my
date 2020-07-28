import { Controller } from "stimulus";

export default class extends Controller {
  static get targets(): Array<string> {
    return ["source"];
  }

  readonly sourceTarget!: HTMLInputElement;

  copy(event: Event): void {
    event.preventDefault();
    this.sourceTarget.select();
    document.execCommand("copy");
  }
}
