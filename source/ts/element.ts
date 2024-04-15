import { Color, Tile, TileStamp } from "./types";

if (!window["customElements"]) {
  throw new Error(
    "window.customElements does not exist. Please use an appropriate polyfill"
  );
}

const getPixel = (
  width: number,
  x: number,
  y: number,
  pixels: number[]
): number => {
  return pixels[x + width * y] ?? -1;
};

class PixelRendererElement extends HTMLElement {
  private canvas?: HTMLCanvasElement;
  private context?: CanvasRenderingContext2D;
  private tileStamps_: TileStamp[] = [];
  tiles: Tile[] = [];
  colors: Color[] = [];

  static get observedAttributes() {
    return ["width", "height"];
  }

  /**
   * Run when the element is put on the page. We prepare stuff here.
   */
  connectedCallback() {
    if (this.canvas && this.context) {
      return;
    }

    // Create the child `<canvas>`.
    this.canvas = document.createElement("canvas");
    this.appendChild(this.canvas);
    this.canvas.style.display = "flex";
    this.canvas.style.imageRendering = "pixelated";

    // The 2D context is the actual interface we use to paint the canvas.
    const context = this.canvas.getContext("2d");
    if (!context) {
      throw new Error("Could not get 2D context from canvas element.");
    }
    this.context = context;

    this.updateStyles();
    this.paintCanvas();
  }

  /**
   * Run whenever the element's attributes get changed.
   */
  attributeChangedCallback(name: string, oldValue: unknown, newValue: unknown) {
    if ((name === "width" || name === "height") && oldValue !== newValue) {
      this.updateStyles();
    }
  }

  set tileStamps(tileStamps: TileStamp[]) {
    this.tileStamps_ = tileStamps;
    this.paintCanvas();
  }

  /**
   * Updates dimensions of the child `<canvas>` element according to values set
   * via attributes.
   */
  private updateStyles() {
    if (!this.canvas) {
      return;
    }

    const width = Number(this.getAttribute("width"));
    const height = Number(this.getAttribute("height"));

    this.canvas.style.width = width + "px";
    this.canvas.style.height = height + "px";
    this.canvas.width = width;
    this.canvas.height = height;
  }

  private paintCanvas(): void {
    if (!this.canvas || !this.context) {
      return;
    }

    const tileImages = this.tiles.map(({ width, pixels }) => {
      const height = Math.ceil(pixels.length / width);
      const imageData = this.context?.createImageData(width, height);

      if (imageData) {
        for (let x = 0; x < width; x += 1) {
          for (let y = 0; y < height; y += 1) {
            const offset = x * 4 + width * 4 * y;
            const pixel = getPixel(width, x, y, pixels);
            const color = this.colors[pixel];

            imageData.data[offset + 0] = (color?.red ?? 0) * 0xff;
            imageData.data[offset + 1] = (color?.green ?? 0) * 0xff;
            imageData.data[offset + 2] = (color?.blue ?? 0) * 0xff;
            imageData.data[offset + 3] = (color?.alpha ?? 1) * 0xff;
          }
        }
      }

      return imageData;
    });

    this.tileStamps_.forEach(({ x, y, tileIndex }) => {
      const tileImage = tileImages[tileIndex];
      if (tileImage) {
        this.context?.putImageData(tileImage, x, y);
      }
    });
  }
}

customElements.define("pixel-renderer", PixelRendererElement);
