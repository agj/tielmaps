import { Elm } from "../elm/Main.elm";

const app = Elm.Main.init({
  node: document.getElementById("elm"),
  flags: {
    viewport: {
      width: window.innerWidth,
      height: window.innerHeight,
    },
  },
});

app.ports.paintCanvas.subscribe(({ width, height, pixels }) => {
  const canvas = document.getElementById("canvas");
  const ctx = canvas.getContext("2d");

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

  ctx.putImageData(imageData, 8, 8);
});

const getPixel = (width, x, y, pixels) => {
  return pixels[x + width * y];
};
