# Elm platformer (temporary name)

I started this (still early-stages) project to sate my curiosity. I wanted to learn more about the [Elm][elm] language, and try making a web browser-runnable, barebones pixel platformer basically from the ground up, while focusing on its core elements. The idea of designing the pixel art and levels by writing “ASCII art” sounded really fun, like how the limitations of coding on old home computers was (probably) like. Making it monochrome also arose from the idea of reducing things to their minimal essence. I didn't wanna make a complex game, just a technical foundation that could foreseeably be expanded upon in future projects, either by myself or any others.

So I wanna make this an easy to hack codebase, sensibly organized for easy comprehension, and release it for anyone interested in making their own platformer but doesn't know where to start, or game makers interested in Elm in particular who want a working example, or for those interested in purely functional languages in general who want to see how a game can be structured under that paradigm. So far it still needs a lot of work, so in the mean time bear with me, or give me some feedback on the code thus far!

— agj

[elm]: https://elm-lang.org/
[node]: https://nodejs.org/
[parcel]: https://parceljs.org/

## Developing

You'll need [Node][node] 14 or higher. After cloning this repository, go into that directory in a terminal and run `npm install`.

The project uses [Parcel][parcel] to bundle everything up, but you don't need to install it manually. Running the `npm run build` command will create the output HTML and JS files in the `dist/` folder.

To develop, use the `npm run develop` command. It will allow you to see changes in your browser as you modify the files, although some times a hard refresh will be necessary. After you run the command, and provided the code has no errors, a URL will get displayed, which you can then open in your browser to see the game live. To stop it, press ctrl+C in the terminal.

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
