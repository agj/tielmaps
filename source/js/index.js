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
  const imageData = ctx.createImageData(width, height);
  for (let x = 0; x < width; ++x) {
    for (let y = 0; y < height; ++y) {
      const cur = getPixel(height, x, y, pixels);
      imageData.data[x * 4 + 0] = cur * 255; // red
      imageData.data[x * 4 + 1] = cur * 255; // green
      imageData.data[x * 4 + 2] = cur * 255; // blue
      imageData.data[x * 4 + 3] = 255; // alpha
    }
  }

  const canvas = document.getElementById("canvas");
  const ctx = canvas.getContext("2d");
  ctx.putImageData(imageData, 0, 0);
});

const getPixel = (height, x, y, pixels) => {
  return pixels[height * y + x];
};
