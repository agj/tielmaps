# Elm platformer (temporary name)

This is a work in progress by **agj** that aims to eventually become a barebones pixel platformer video game made in [Elm][elm]. The idea is for it to be an easy to hack codebase, for anyone interested in making their own platformer but doesn't know where to start, or for game makers interested in Elm in particular who want a working example, or for those interested in purely functional languages in general and want to see how a game can be structured under that paradigm.

[elm]: https://elm-lang.org/
[node]: https://nodejs.org/
[parcel]: https://parceljs.org/

## Developing

You'll need [Node][node] 14 or higher. After cloning this repository, go to the directory in a terminal and run `npm install`.

The project uses [Parcel][parcel] to bundle everything up. Running the `npm run build` command will create the output HTML and JS files in the `dist/` folder.

To develop, running `npm run develop` will run a development server that you can access by entering in your browser the address that gets output in the terminal. Any changes you make to the files will automatically be reflected in the webpage (many times a reload will still be necessary, though). Press ctrl+C in the terminal to stop the server.

## License

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
