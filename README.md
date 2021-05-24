# Tielmaps

See what this code compiles down to [here](https://agj.github.io/tielmaps/).

I started this (still early-stages) project to sate my curiosity. I wanted to learn more about the [Elm][elm] programming language, and try making a web browser-runnable, barebones pixel platformer game basically from the ground up, while focusing only on its core elements.

All graphics are drawn using plain text. The idea of designing the pixel art and levels by writing “ASCII art” sounded really fun, like how the limitations of coding on old home computers was (probably) like. Making it monochrome also arose from the idea of reducing things to their minimal essence. I didn't wanna make a complex game, just a technical foundation that could foreseeably be expanded upon in future projects, either by myself or any others.

So I wanna make this an easy to hack codebase, sensibly organized for easy comprehension, and release it for anyone interested in making their own platformer but doesn't know where to start, game makers interested in Elm in particular who want a working example, or those interested in purely functional languages who want to see how a game can be structured under that paradigm. So far it still needs a lot of work, so in the mean time bear with me, or give me some feedback on the code thus far!

— agj

[elm]: https://elm-lang.org/
[node]: https://nodejs.org/
[parcel]: https://parceljs.org/

## The code

The files are organized in this way:

- `source/` holds all the source files.
  - `elm/` holds the Elm code that does all the magic. Start with the `Main.elm` file.
  - `elm/Main.d.ts` is a Typescript types declaration file. Basically just makes the Elm code more understandable to Typescript code.
  - `ts/index.ts` holds some wrapping Typescript code for the Elm stuff. The few lines of code that receive data from the Elm side and actually place pixels on the screen are here.
  - `html/index.html` is just the single HTML file that will hold all the other stuff.
- `tests/` has some unit tests, not very important unless you care about those.
- `benchmarks/` has some code that checks how fast or slow some code is—also not very important. This code is set up as a separate Elm project in its own folder.
- `elm.json` has all the Elm configuration in it, like the packages this project depends on. It shouldn't be necessary to manipulate directly.
- `package.json` has the Node configuration, also some package dependencies. Defines some scripts to simplify development (read more about that in the following section).

## Hack it

You'll need [Node][node] 14 or higher. After cloning this repository, go into that directory in a terminal and run `npm install`.

The project uses [Parcel][parcel] to bundle everything up, but you don't need to install it manually. Running the `npm run build` command will create the output HTML and JS files inside the `dist/` folder.

To develop, use the `npm run develop` command. It will allow you to see changes in your browser as you modify the files, although some times a hard refresh will be necessary. After you run the command, and provided the code has no errors, a URL will get displayed, which you can then open in your browser to see the game live. To stop it, press ctrl+C in the terminal.

Other (less necessary) commands are `npm test` to run unit tests, and `npm benchmark` to see some benchmarks.

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
