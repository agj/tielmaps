/**
 * This file provides Typescript types that describe the interface with Elm.
 * It's mostly been jacked from https://github.com/Punie/elm-typescript-starter
 *
 */

import { ElmApp, ElmConfig } from "../ts/types";

export namespace Elm {
  export namespace Main {
    export function init(config: ElmConfig): ElmApp;
  }
}
