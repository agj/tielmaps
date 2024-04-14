import { Elm } from "../elm/Main.elm";
import "./element";

const app = Elm.Main.init({
  node: document.getElementById("elm"),
  flags: {
    viewport: {
      width: window.innerWidth,
      height: window.innerHeight,
    },
  },
});
