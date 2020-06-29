import { Controller } from "stimulus";
import hljs from "highlight.js/lib/core";
import Quill from "quill";

import "highlight.js/styles/github.css";
import "quill/dist/quill.snow.css";

export default class extends Controller {
  static get targets() {
    return ["editor", "input"];
  }

  connect() {
    this.editor = new Quill(this.editorTarget, this.editorOptions);

    if (this.hasInputTarget) {
      this.editor.on("text-change", this.textChanged.bind(this));
    }

    this.editor.setContents(this.initialContent);

    this.turnOffToolbarTabbing();
  }

  textChanged() {
    const editorContent = JSON.stringify(this.editor.getContents());
    this.inputTarget.value = editorContent;
  }

  turnOffToolbarTabbing() {
    document.querySelectorAll(".ql-toolbar button").forEach((el) => {
      el.tabIndex = -1;
    });

    document.querySelectorAll(".ql-toolbar .ql-picker-label").forEach((el) => {
      el.tabIndex = -1;
    });
  }

  get editorOptions() {
    return {
      modules: {
        syntax: true,
        syntax: {
          highlight: (text) => hljs.highlightAuto(text).value,
        },
        // toolbar: this.isReadonly ? null : this.toolbarOptions,
        toolbar: this.isReadonly ? null : this.toolbarOptions,
      },
      readOnly: this.isReadonly,
      theme: this.theme,
    };
  }

  get toolbarOptions() {
    return [
      ["bold", "italic", "underline", "strike"], // toggled buttons
      ["blockquote", "code-block"],

      [{ list: "ordered" }, { list: "bullet" }],
      [{ indent: "-1" }, { indent: "+1" }], // outdent/indent

      [{ size: ["small", false, "large", "huge"] }], // custom dropdown

      [{ color: [] }, { background: [] }], // dropdown with defaults from theme
      [{ font: [] }],
      [{ align: [] }],

      ["clean"], // remove formatting button
    ];
  }

  get isReadonly() {
    const dataValue = this.data.get("readonly");

    if (dataValue === "true") {
      return true;
    }

    return false;
  }

  get theme() {
    const defaultTheme = "snow";
    const dataValue = this.data.get("theme");

    if (dataValue !== null) {
      return dataValue;
    }

    return defaultTheme;
  }

  get initialContent() {
    const defaultContent = null;
    const contentValue = this.data.get("initialContent");

    if (contentValue !== null) {
      try {
        return JSON.parse(contentValue);
      } catch (e) {
        return defaultContent;
      }
    }

    return defaultContent;
  }
}
