// Copyright 2022 Jonathan Lindegaard Starup
//
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
//
//        http://www.apache.org/licenses/LICENSE-2.0
//
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.

// For more information see here
// https://en.wikipedia.org/wiki/ANSI_escape_code

namespace Terminal {

    ///
    /// Moves the cursor `n` cells up. If the cursor is / already at the edge of
    /// the screen, or if `n` is non-positive, this has no / effect.
    ///
    pub def cursorUp(n: Int32): Unit \ IO =
        if (n <= 0) () else
        output(csi("${n}A"))

    ///
    /// Moves the cursor `n` cells down. If the cursor is already at the edge of
    /// the screen, or if `n` is non-positive, this has no effect.
    ///
    pub def cursorDown(n: Int32): Unit \ IO =
        if (n <= 0) () else
        output(csi("${n}B"))

    ///
    /// Moves the cursor `n` cells forward. If the cursor is already at the edge of
    /// the screen, or if `n` is non-positive, this has no effect.
    ///
    pub def cursorForward(n: Int32): Unit \ IO =
        if (n <= 0) () else
        output(csi("${n}C"))

    ///
    /// Moves the cursor `n` cells back. If the cursor is already at the edge of
    /// the screen, or if `n` is non-positive, this has no effect.
    ///
    pub def cursorBack(n: Int32): Unit \ IO =
        if (n <= 0) () else
        output(csi("${n}D"))

    ///
    /// Moves the cursor to row `n`, column `m`, starting at `(0, 0)`.
    ///
    pub def cursorTo(x: {x::Int32}, y: Int32): Unit \ IO =
        if (x.x < 0 or y < 0) () else
        if (x.x == 0 and y == 0) () else
        // ones could be ommited here for output brevity
        output(csi("${y+1};${x.x+1}H"))

    ///
    /// Clears part of the screen. If n is 0, clear from cursor to end of
    //screen. If n is 1, clear from cursor to beginning of the screen. If n is
    //2, clear entire screen (and moves cursor to upper left on DOS ANSI.SYS).
    //If n is 3, clear entire screen and delete all lines saved in the
    //scrollback buffer (this feature was added for xterm and is supported by
    //other terminal applications).

    ///
    /// Clear from cursor to end of screen.
    ///
    pub def clearScreenAfterCursor(): Unit \ IO =
        // implicitely give argument 0
        output(csi("J"))

    ///
    /// Clear from cursor to beginning of the screen.
    ///
    pub def clearScreenBeforeCursor(): Unit \ IO =
        output(csi("1J"))

    ///
    /// Clear entire screen and moves cursor to upper left.
    ///
    pub def clearScreenAndReset(): Unit \ IO =
        output(csi("2J"))

    ///
    /// Clear entire screen and delete all lines saved in the scrollback buffer
    /// thereby also resetting the cursor.
    ///
    pub def clearScreenAndBuffer(): Unit \ IO =
        output(csi("3J"))

    ///
    /// Clear from cursor to the end of the line.
    /// Cursor position does not change.
    ///
    pub def clearLineAfterCursor(): Unit \ IO =
        // implicitely give argument 0
        output(csi("K"))

    ///
    /// Clear from cursor to beginning of the line.
    /// Cursor position does not change.
    ///
    pub def clearLineBeforeCursor(): Unit \ IO =
        output(csi("1K"))

    ///
    /// Clear entire line. Cursor position does not change.
    ///
    pub def clearLine(): Unit \ IO =
        output(csi("2K"))


    def output(x: s): Unit \ IO with ToString[s] =
        Console.print(x)

    def escape(s: String): String =
        "\u001B${s}"

    def csi(s: String): String =
        escape("[${s}")

}
