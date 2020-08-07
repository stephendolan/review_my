import { Controller } from "stimulus";

export default class extends Controller {
  static get targets(): Array<string> {
    return ["replace", "source"];
  }

  readonly sourceTarget!: HTMLInputElement;
  readonly hasReplaceTarget!: boolean;
  readonly replaceTarget!: HTMLElement;

  copy(event: Event): void {
    event.preventDefault();
    this.sourceTarget.select();
    document.execCommand("copy");

    if (this.hasReplaceTarget) {
      this.replaceTarget.innerHTML = `Copied! ${this.randomSuccessMessage()}!`;
    }
  }

  private randomSuccessMessage(): string {
    const messages = [
      "You really clicked that button",
      "Now share it with friends",
      "Go forth, and conquer",
      "That tickled",
      "Woohoo",
      "Way to go",
    ];

    return messages[Math.floor(Math.random() * messages.length)];
  }
}
