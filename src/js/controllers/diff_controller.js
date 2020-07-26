import { Controller } from "stimulus";
import DiffMatchPatch from "diff-match-patch";
import he from "he";

// Given an old and new target, calculate the difference and display
// it in the display target.
export default class extends Controller {
  static get targets() {
    return ["old", "new", "display"];
  }

  initialize() {
    this.calculateAndDisplayDiff();

    this.newTarget.addEventListener("trix-change", () => {
      this.calculateAndDisplayDiff();
    });
  }

  calculateAndDisplayDiff() {
    const oldContent = this.sanitize(this.oldTarget.innerHTML);
    const newContent = this.sanitize(this.newTarget.innerHTML);

    const diff = new DiffMatchPatch();
    const htmlDiff = diff.diff_main(oldContent, newContent);
    diff.diff_cleanupSemantic(htmlDiff);

    htmlDiff.forEach((section, index) => {
      const [status, content] = section;

      if (this.skipContent(content)) {
        return;
      }

      if (status === -1) {
        htmlDiff[index][1] = `<span class="bg-red-300">${content}</span>`;
      }

      if (status === 1) {
        htmlDiff[index][1] = `<span class="bg-green-300">${content}</span>`;
      }
    });

    this.displayTarget.innerHTML = this.joinDiff(htmlDiff);
  }

  skipContent(content) {
    const htmlComment = /^(<!--[^>]*?-->)*$/;
    const htmlTag = /^(<[^>]*?>)*$/;

    if (content.match(htmlComment)) {
      return true;
    }

    if (content.match(htmlTag)) {
      return true;
    }

    return false;
  }

  sanitize(content) {
    const strippedContent = content.replace(/<!--\s*block\s*-->/g, "");
    const decodedContent = he.decode(strippedContent);

    return decodedContent;
  }

  joinDiff(diffArray) {
    let returnString = "";

    diffArray.forEach(section => {
      const [status, content] = section;
      returnString += content;
    });

    return returnString;
  }
}
