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
    const oldContent = this.oldTarget.innerHTML;
    const newContent = this.newTarget.innerHTML;

    const prettyDiff = this.prettyDiff(oldContent, newContent);

    this.displayTarget.innerHTML = this.sanitize(prettyDiff);
  }

  prettyDiff(oldText, newText) {
    const differ = new DiffMatchPatch();

    // Get the main diff, character by character
    const htmlDiff = differ.diff_main(oldText, newText);

    // Make the diff output a bit more readable to a human
    differ.diff_cleanupSemantic(htmlDiff);

    // Take the diff and turn it into valid HTML
    return differ.diff_prettyHtml(htmlDiff);
  }

  // Because we're dealing with a Trix editor, <div>s are the only
  // block elements we really run into issues with around <ins> and <del> inline elements.
  // This removes all of the divs, and then wraps them around <br> tags to preserve whitespace.
  sanitize(html) {
    let returnHtml = he.decode(html);

    // Move newlines from divs to brs
    returnHtml = returnHtml.replace(/<\/?div>/g, "");
    returnHtml = returnHtml.replace(/<br>/g, "<div><br></div>");

    // Replace <ins> backgrounds with TailwindCSS colors
    returnHtml = returnHtml.replace(
      /<ins style="background:#.{6};">/g,
      '<ins class="bg-green-200">'
    );

    // Replace <del> backgrounds with TailwindCSS colors
    returnHtml = returnHtml.replace(
      /<del style="background:#.{6};">/g,
      '<del class="bg-red-200">'
    );

    return returnHtml;
  }
}
