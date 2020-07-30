import { Controller } from "stimulus";
import { diff_match_patch } from "diff-match-patch";
import he from "he";

// Given an old and new target, calculate the difference and display
// it in the display target.
export default class extends Controller {
  readonly newTarget!: Element;
  readonly oldTarget!: Element;
  readonly displayTarget!: Element;

  static get targets(): Array<string> {
    return ["old", "new", "display"];
  }

  initialize(): void {
    this.calculateAndDisplayDiff();

    this.newTarget.addEventListener("trix-change", () => {
      this.calculateAndDisplayDiff();
    });
  }

  calculateAndDisplayDiff(): void {
    const oldContent = this.oldTarget.innerHTML;
    const newContent = this.newTarget.innerHTML;

    const prettyDiff = this.prettyDiff(oldContent, newContent);

    this.displayTarget.innerHTML = this.sanitize(prettyDiff);
  }

  prettyDiff(oldText: string, newText: string): string {
    const differ = new diff_match_patch();

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
  sanitize(html: string): string {
    let returnHtml = he.decode(html);

    // Move newlines from divs to brs, strip comments
    returnHtml = returnHtml.replace(/<\/?div>/g, "");
    returnHtml = returnHtml.replace(/<!--\s*block\s*-->/g, "");
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
