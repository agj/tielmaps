# Tielmaps

[See what this code compiles down to here](https://agj.github.io/tielmaps/). It's a little platformer game you can play on a desktop computer. Press the left and right keys to move sideways, and space to jump.

I started this (still in-progress) project to sate my curiosity. I wanted to learn more about the [Elm programming language][elm], and try making a web browser-runnable, barebones pixel platformer game basically from the ground up, while focusing only on its core elements.

All graphics are drawn using plain text. The idea of designing the pixel art and levels by writing “ASCII art” sounded really fun, like how the limitations of coding on old home computers was (probably) like. Making it monochrome also arose from the idea of reducing things to their minimal essence. I didn't wanna make a complex game, just a technical foundation that could foreseeably be expanded upon in future projects, either by myself or any others.

So I wanna make this an easy to hack codebase, sensibly organized for easy comprehension, and release it for: people interested in making their own platformer, but who don't know where to start; game makers interested in Elm who want a working example; or programmers interested in purely functional, strongly-typed languages who want to see how a game could be structured under that paradigm.

I myself am learning through this process, so I don't claim I have the right approach, and it'll probably change as it moves forward. So far it still needs a lot of work, but feel welcome to send your feedback this way!

— agj

[elm]: https://elm-lang.org/
[node]: https://nodejs.org/
[parcel]: https://parceljs.org/
[ts]: https://www.typescriptlang.org/

## The code

The files are organized in this way:

- `source/` holds all the source files.
  - `elm/` holds the Elm code that does all the magic.
    - `Main.elm` is the Elm entry point. **Start looking here!**
    - `Assets/` has files with pictures of tiles, sprites and tilemaps, which are used in the demo level.
    - `Main.d.ts` is a Typescript types declaration file. Basically just makes the Elm code more understandable to Typescript code.
  - `ts/index.ts` holds some wrapping Typescript code for the Elm stuff. The few lines of code that receive data from the Elm side and actually place pixels on the screen are here.
  - `html/index.html` is just the single HTML file that will hold all the other stuff.
- `tests/` has some unit tests. Not very important unless you care about those.
- `benchmarks/` has some code that checks how fast or slow some code is. Also not very important. This folder is set up as a separate Elm project with its own dependencies.
- `elm.json` has all the Elm configuration in it, like the packages this project depends on. It shouldn't be necessary to manipulate this directly.
- `package.json` has the Node configuration, also some package dependencies. Defines some scripts to simplify development (read more about that in the following section).

## Hack it

You'll need [Node][node] 14 or higher installed. After downloading or cloning this repository into your computer, go into that directory in a terminal and run `npm install`. This will install other dependencies automatically, like the [Parcel][parcel] bundler.

The bulk of the code is written in [Elm][elm], but a bit of it is [Typescript][ts], which is just Javascript with types (which helps by giving errors if you use things incorrectly).

Running the `npm run build` command will create the output HTML and JS files inside the `dist/` folder.

To develop, use the `npm run develop` command. It will allow you to see changes in your browser as you modify the files. After you run the command, and provided the code has no errors, a URL will get displayed, which you can then open in your browser to see the game live. To stop it, press ctrl+C in the terminal. After you make some big changes, you might need to refresh the browser. Also, Parcel has some trouble with Elm projects currently, and it will stop updating when there's a compiler error (I hope they fix this soon), so you might need to ctrl+C and then run the command again from time to time.

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
