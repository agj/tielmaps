import { Bitmap, Elm, Pixel } from "../elm/Main";

const app = Elm.Main.init({
  node: document.getElementById("elm"),
  flags: {
    viewport: {
      width: window.innerWidth,
      height: window.innerHeight,
    },
  },
});

app.ports.command.subscribe(({ kind, value }) => {
  switch (kind) {
    case "paintCanvas":
      return paintCanvas(value);
    default:
      return;
  }
});

const paintCanvas = ({ width, height, pixels }: Bitmap) => {
  const canvas = document.getElementById("canvas");

  if (canvas instanceof HTMLCanvasElement) {
    const ctx = canvas.getContext("2d");
    if (ctx instanceof CanvasRenderingContext2D) {
      const imageData = ctx.createImageData(width, height);
      for (let x = 0; x < width; ++x) {
        for (let y = 0; y < height; ++y) {
          const offset = x * 4 + width * 4 * y;
          const pixelOn = 1 - getPixel(width, x, y, pixels);
          imageData.data[offset + 0] = pixelOn * 0xff; // red
          imageData.data[offset + 1] = pixelOn * 0xff; // green
          imageData.data[offset + 2] = pixelOn * 0xff; // blue
          imageData.data[offset + 3] = 0xff; // alpha
        }
      }

      ctx.putImageData(imageData, 0, 0);
    }
  }
};

const getPixel = (
  width: number,
  x: number,
  y: number,
  pixels: Array<Pixel>
): Pixel => {
  return pixels[x + width * y] ?? 0;
};
