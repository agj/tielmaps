# Tielmaps

This is a foundation for a pixel platformer game playable on a computer (not a mobile device, currently).

- See the code on [Github][tm-github].
- Play what this compiles down to on [Github Pages][tm-ghpages].

Controls:

| key   | result         |
| ----- | -------------- |
| ← →   | Move sideways. |
| space | Jump.          |

Feel free to fork and make your own game!

![Screenshot of the demo game](./screenshot.png)

## Introduction

I started this (still in-progress) project to sate my own curiosity. I wanted to learn more about the [Elm programming language][elm], and try making a web browser-runnable, barebones pixel platformer game basically from the ground up, while focusing only on its core elements.

I wanted to make this as self-contained as possible, so graphics are drawn using an 8 × 8 grid of “ASCII art” and then passed through a function that transforms it into structured data. Map screens are also designed in this same way. It's actually a really fun way of drawing the art and designing the levels, I think!

```
█ █ █ █ █ █ █ █
█ . . . . . . █
█ . . █ . █ . █
█ . . . . . . █
█ █ █ █ █ █ █ █
/ █ / / █ █ / /
█ █ / / / / █ /
/ / / / / / / /
```

I also went for a monochrome art style, wanting to reduce things to their minimal essence. The idea is not to make a complex game, just a technical foundation that could foreseeably be expanded upon.

So I hope that this is an easy to hack codebase, sensibly organized for easy comprehension. It's intended for people interested in making their own platformer, but who don't know where to start; game makers interested in Elm who want a working example; or programmers interested in purely functional, strongly-typed languages who want to see how a game could be structured under that paradigm.

I myself am learning through this process, so I don't claim I have the right approach, and it'll probably change as it moves forward. Feel welcome to fork and extend, or to send feedback this way!

— agj

[tm-github]: https://github.com/agj/tielmaps
[tm-ghpages]: https://agj.github.io/tielmaps/
[elm]: https://elm-lang.org/
[node]: https://nodejs.org/
[parcel]: https://parceljs.org/
[ts]: https://www.typescriptlang.org/
[elmjson]: https://github.com/elm/compiler/blob/master/docs/elm.json/application.md
[packagejson]: https://nodejs.org/en/knowledge/getting-started/npm/what-is-the-file-package-json/
[tsconfig]: https://www.typescriptlang.org/docs/handbook/tsconfig-json.html
[envvar]: https://en.wikipedia.org/wiki/Environment_variable

## The code

The files are organized this way:

- `source/` holds all the source files.
  - `elm/` holds the Elm code that does all the magic.
    - `Main.elm` is the Elm entry point. **Start looking here!**
    - `Assets/` has files with pictures of tiles, sprites and tilemaps, which are used in the demo level.
    - `Main.d.ts` is a TypeScript types declaration file. Basically just makes the Elm code more understandable to TypeScript code.
  - `ts/index.ts` holds some wrapping TypeScript code for the Elm stuff. The few lines of code that receive data from the Elm side and actually place pixels on the screen are here.
  - `html/index.html` is just the single HTML file that will hold all the other stuff.
- `tests/` has some unit tests. Not very important unless you care about those.
- `benchmarks/` has some code that checks how fast or slow some code is. Also not very important. This folder is set up as a separate Elm project with its own dependencies.
- `elm.json` has all the [Elm configuration][elmjson] in it, like the packages this project depends on.
- `package.json` has the [Node configuration][packagejson], including its package dependencies. Defines some scripts to simplify development (read more about that in the following section).
- `ts-config.json` has the [TypeScript configuration][tsconfig]; basically some rules on how to interpret the code and convert to JavaScript.
- `.parcelrc` tells Parcel that it should use the TypeScript compiler for the TypeScript code.
- `.env` contains [environment variables][envvar], specifically one that tells Parcel not to use the Elm debugger, because it sadly slows down this application due to its many events per second.

## Hack it

To start, you'll need [Node][node] 14 or higher installed.

After downloading or cloning this repository into your computer, go into that directory in a terminal and run `npm install`. This will install other dependencies, like the [Parcel][parcel] bundler.

The bulk of the code is written in [Elm][elm], but a bit of it is [TypeScript][ts] (just JavaScript with types).

Running the `npm run build` command will create the output HTML and JS files inside the `dist/` folder.

To develop, use the `npm run develop` command. It will allow you to see changes in your browser as you modify the files. After you run the command, and provided the code has no errors, a URL will get displayed, which you can then open in your browser to see the game live. To stop it, press ctrl+C in the terminal. After you make some big changes, you might need to refresh the browser.

Other (less important) commands are `npm test` to run unit tests, and `npm benchmark` to see some benchmarks.

## Unlicense

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>
