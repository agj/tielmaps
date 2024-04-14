import { PaintCanvasInstructions, Pixel } from "./types";

if (!window["customElements"]) {
  throw new Error(
    "window.customElements does not exist. Please use an appropriate polyfill"
  );
}

const baseStyles = [
  "image-rendering: crisp-edges",
  "image-rendering: pixelated",
].join(";");

const getPixel = (
  width: number,
  x: number,
  y: number,
  pixels: Array<Pixel>
): Pixel => {
  return pixels[x + width * y] ?? -1;
};

class Bla extends HTMLElement {
  canvas?: HTMLCanvasElement;
  context?: CanvasRenderingContext2D;
  instructions?: PaintCanvasInstructions;

  constructor() {
    super();
  }

  static get observedAttributes() {
    return ["width", "height", "style"];
  }

  connectedCallback() {
    this.canvas = document.createElement("canvas");
    this.appendChild(this.canvas);
    const context = this.canvas.getContext("2d");
    if (!context) {
      throw new Error("Could not get 2D context from canvas element.");
    }
    this.context = context;

    // this.setCanvasDimensions();
    // this.paintCanvas();
  }

  disconnectedCallback() {
    if (!this.canvas) {
      return;
    }

    this.removeChild(this.canvas);
    this.canvas = undefined;
    this.context = undefined;
  }

  attributeChangedCallback(name: string, oldValue: unknown, newValue: unknown) {
    if (
      (name === "width" || name === "height" || name === "style") &&
      oldValue !== newValue
    ) {
      requestAnimationFrame(() => {
        this.setCanvasDimensions();
        this.paintCanvas();
      });
    }
  }

  set scene(instructions: PaintCanvasInstructions) {
    this.instructions = instructions;
    this.paintCanvas();
  }

  setCanvasDimensions() {
    if (!this.canvas || !this.context) {
      return;
    }

    const styles = this.getAttribute("style");
    this.canvas.setAttribute("style", `${baseStyles};${styles}`);

    const width = Number(this.getAttribute("width"));
    const height = Number(this.getAttribute("height"));

    const devicePixelRatio = window.devicePixelRatio ?? 1;
    this.canvas.style.width = width + "px";
    this.canvas.style.height = height + "px";
    this.canvas.width = width * devicePixelRatio;
    this.canvas.height = height * devicePixelRatio;

    // Reset current transformation matrix to the identity matrix
    this.context.setTransform(1, 0, 0, 1, 0, 0);
    this.context.scale(devicePixelRatio, devicePixelRatio);
  }

  paintCanvas(): void {
    if (!this.canvas || !this.context || !this.instructions) {
      return;
    }

    const {
      lightColor,
      darkColor,
      bitmap: { width, height, pixels },
    } = this.instructions;

    const imageData = this.context.createImageData(width, height);

    const lightR = lightColor.red * 0xff;
    const lightG = lightColor.green * 0xff;
    const lightB = lightColor.blue * 0xff;
    const darkR = darkColor.red * 0xff;
    const darkG = darkColor.green * 0xff;
    const darkB = darkColor.blue * 0xff;

    for (let x = 0; x < width; ++x) {
      for (let y = 0; y < height; ++y) {
        const offset = x * 4 + width * 4 * y;
        const pixel = getPixel(width, x, y, pixels);
        const alpha = pixel === -1 ? 0x00 : 0xff;

        imageData.data[offset + 0] = pixel === 1 ? lightR : darkR;
        imageData.data[offset + 1] = pixel === 1 ? lightG : darkG;
        imageData.data[offset + 2] = pixel === 1 ? lightB : darkB;
        imageData.data[offset + 3] = alpha;
      }
    }

    this.context.putImageData(imageData, 0, 0);
  }
}

customElements.define("my-bla", Bla);
