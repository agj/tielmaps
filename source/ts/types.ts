export interface ElmApp {}

export type ElmConfig = {
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
};

export type Color = {
  red: ZeroToOne;
  green: ZeroToOne;
  blue: ZeroToOne;
  alpha?: ZeroToOne;
};

export type Bitmap = {
  readonly width: number;
  readonly height: number;
  readonly pixels: Pixel[];
};

export type Pixel =
  | 0 // Dark
  | 1 // Light
  | -1; // Transparent

export type ZeroToOne = number;

export type Tile = {
  width: number;
  pixels: number[];
};

export type TileStamp = {
  x: number;
  y: number;
  tileIndex: number;
};
