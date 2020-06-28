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
    if (!this.validTargets()) {
      return;
    }

    this.editor = new Quill(this.editorTarget, this.editorOptions);

    this.editor.on("text-change", this.textChanged.bind(this));

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

  validTargets() {
    if (this.editorTarget == undefined) {
      console.error("Editor target undefined");
      return false;
    }

    if (this.inputTarget == undefined) {
      console.error("Input target undefined");
      return false;
    }

    return true;
  }

  get editorOptions() {
    return {
      modules: {
        syntax: true,
        syntax: {
          highlight: (text) => hljs.highlightAuto(text).value,
        },
        toolbar: this.toolbarOptions,
      },
      theme: "snow",
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
}
