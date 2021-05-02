// Elm entrypoint

export namespace Elm {
  export namespace Main {
    export function init(config: Config): App;
  }
}

export interface App {
  readonly ports: Ports;
}

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

// Ports

export type Ports = {
  readonly command: Cmd<Action>;
};

export type Cmd<T> = {
  subscribe(callback: (value: T) => void): void;
  unsubscribe(callback: (value: T) => void): void;
};

// Actions

export type Action = PaintCanvasAction;

export type PaintCanvasAction = {
  readonly kind: "paintCanvas";
  readonly value: Bitmap;
};

// Values

export type Bitmap = {
  readonly width: number;
  readonly height: number;
  readonly pixels: Array<Pixel>;
};

export type Pixel = 0 | 1;
