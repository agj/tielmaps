import { Bitmap, ColorsAndBitmap, Elm, Pixel } from "../elm/Main.elm";

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

const paintCanvas = ({
  lightColor,
  darkColor,
  bitmap: { width, height, pixels },
}: ColorsAndBitmap): void => {
  const canvas = document.getElementById("canvas");

  if (canvas instanceof HTMLCanvasElement) {
    const ctx = canvas.getContext("2d");
    if (ctx instanceof CanvasRenderingContext2D) {
      const imageData = ctx.createImageData(width, height);

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
  return pixels[x + width * y] ?? -1;
};
