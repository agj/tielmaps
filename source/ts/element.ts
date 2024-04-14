import { PaintCanvasInstructions, Pixel } from "./types";

if (!window["customElements"]) {
  throw new Error(
    "window.customElements does not exist. Please use an appropriate polyfill"
  );
}

const getPixel = (
  width: number,
  x: number,
  y: number,
  pixels: Array<Pixel>
): Pixel => {
  return pixels[x + width * y] ?? -1;
};

class PixelRendererElement extends HTMLElement {
  canvas?: HTMLCanvasElement;
  context?: CanvasRenderingContext2D;
  instructions?: PaintCanvasInstructions;

  constructor() {
    super();
  }

  static get observedAttributes() {
    return ["width", "height"];
  }

  connectedCallback() {
    // Create the child `<canvas>`.
    this.canvas = document.createElement("canvas");
    this.appendChild(this.canvas);
    this.canvas.style.imageRendering = "pixelated";
    const context = this.canvas.getContext("2d");
    if (!context) {
      throw new Error("Could not get 2D context from canvas element.");
    }
    this.context = context;

    this.updateStyles();
    this.paintCanvas();
  }

  disconnectedCallback() {
    if (!this.canvas) {
      return;
    }

    // Clean up.
    this.removeChild(this.canvas);
    this.canvas = undefined;
    this.context = undefined;
  }

  attributeChangedCallback(name: string, oldValue: unknown, newValue: unknown) {
    if ((name === "width" || name === "height") && oldValue !== newValue) {
      requestAnimationFrame(() => {
        this.updateStyles();
        this.paintCanvas();
      });
    }
  }

  set scene(instructions: PaintCanvasInstructions) {
    this.instructions = instructions;
    this.paintCanvas();
  }

  updateStyles() {
    if (!this.canvas || !this.context) {
      return;
    }

    const width = Number(this.getAttribute("width"));
    const height = Number(this.getAttribute("height"));

    this.canvas.style.width = width + "px";
    this.canvas.style.height = height + "px";
    this.canvas.width = width;
    this.canvas.height = height;
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

customElements.define("pixel-renderer", PixelRendererElement);
