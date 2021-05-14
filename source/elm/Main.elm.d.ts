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

export interface App {
  readonly ports: Ports;
}

export type Config = {
  readonly node?: Element | null;
  readonly flags: Flags;
};

export type Ports = {
  readonly command: Cmd<Action>;
};

export type Cmd<T> = {
  subscribe(callback: (value: T) => void): void;
  unsubscribe(callback: (value: T) => void): void;
};

// Flags

export type Flags = {
  readonly viewport: Viewport;
};

export type Viewport = {
  readonly width: number;
  readonly height: number;
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
