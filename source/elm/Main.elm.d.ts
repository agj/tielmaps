/**
 * This file provides Typescript types that describe the interface with Elm.
 * It's mostly been jacked from https://github.com/Punie/elm-typescript-starter
 *
 */

// Elm entrypoint

export namespace Elm {
  export namespace Main {
    export function init(config: Config): App;
  }
}

export interface App {}

export type Config = {
  readonly node?: Element | null;
  readonly flags: Flags;
};

// Flags

export type Flags = {
  readonly viewport: Viewport;
};

export type Viewport = {
  readonly width: number;
  readonly height: number;
};

// Values

export type PaintCanvasInstructions = {
  readonly lightColor: Color;
  readonly darkColor: Color;
  readonly bitmap: Bitmap;
  readonly canvasId: string;
};

export type Color = {
  red: ZeroToOne;
  green: ZeroToOne;
  blue: ZeroToOne;
};

export type Bitmap = {
  readonly width: number;
  readonly height: number;
  readonly pixels: Array<Pixel>;
};

export type Pixel =
  | 0 // Dark
  | 1 // Light
  | -1; // Transparent

export type ZeroToOne = number;
