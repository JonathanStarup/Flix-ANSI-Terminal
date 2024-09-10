//
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
//

// For more information see here
// https://en.wikipedia.org/wiki/ANSI_escape_code

mod Terminal {

    ///
    /// Moves the cursor `n` cells up. If the cursor is / already at the edge of
    /// the screen, or if `n` is non-positive, this has no / effect.
    ///
    pub def cursorUp(n: Int32): Unit \ Console =
        if (n <= 0) () else
        output(Terminal.String.cursorUp(n))

    ///
    /// Moves the cursor `n` cells down. If the cursor is already at the edge of
    /// the screen, or if `n` is non-positive, this has no effect.
    ///
    pub def cursorDown(n: Int32): Unit \ Console =
        if (n <= 0) () else
        output(Terminal.String.cursorDown(n))

    ///
    /// Moves the cursor `n` cells forward. If the cursor is already at the edge of
    /// the screen, or if `n` is non-positive, this has no effect.
    ///
    pub def cursorForward(n: Int32): Unit \ Console =
        if (n <= 0) () else
        output(Terminal.String.cursorForward(n))

    ///
    /// Moves the cursor `n` cells back. If the cursor is already at the edge of
    /// the screen, or if `n` is non-positive, this has no effect.
    ///
    pub def cursorBack(n: Int32): Unit \ Console =
        if (n <= 0) () else
        output(Terminal.String.cursorBack(n))

    /// Moves the cursor to row `n`, column `m`, starting at `(0, 0)`.
    pub def cursorTo(row: {row = Int32}, column: Int32): Unit \ Console =
        if (row#row < 0 or column < 0) () else
        output(Terminal.String.cursorTo(row, column))

    /// Clear from cursor (inclusive) to end of screen.
    pub def clearScreenAfterCursor(): Unit \ Console =
        output(Terminal.String.clearScreenAfterCursor())

    /// Clear from cursor (inclusive) to beginning of the screen.
    pub def clearScreenBeforeCursor(): Unit \ Console =
        output(Terminal.String.clearScreenBeforeCursor())

    /// Clear entire screen and moves cursor to upper left.
    pub def clearScreenAndReset(): Unit \ Console =
        output(Terminal.String.clearScreenAndReset())

    ///
    /// Clear from cursor (inclusive) to the end of the line.
    /// Cursor position does not change.
    ///
    pub def clearLineAfterCursor(): Unit \ Console =
        output(Terminal.String.clearLineAfterCursor())

    ///
    /// Clear from cursor (inclusive) to beginning of the line.
    /// Cursor position does not change.
    ///
    pub def clearLineBeforeCursor(): Unit \ Console =
        output(Terminal.String.clearLineBeforeCursor())

    /// Clear entire line. Cursor position does not change.
    pub def clearLine(): Unit \ Console =
        output(Terminal.String.clearLine())

    ///
    /// Saves the current cursor position for later restoration.
    /// OBS: Note that this position does not account for terminal scrolling
    /// when printing newlines at the bottom of the terminal.
    ///
    pub def saveCursor(): Unit \ Console =
        output(Terminal.String.saveCursor())

    /// Restores the previously saved cursor.
    pub def restoreCursor(): Unit \ Console =
        output(Terminal.String.restoreCursor())

    mod String {
        use Terminal.csi

        /// String of the corresponding method in `Terminal`.
        pub def cursorUp(n: Int32): String =
            if (n <= 0) "" else csi("${n}A")

        /// String of the corresponding method in `Terminal`.
        pub def cursorDown(n: Int32): String =
            if (n <= 0) "" else csi("${n}B")

        /// String of the corresponding method in `Terminal`.
        pub def cursorForward(n: Int32): String =
            if (n <= 0) "" else csi("${n}C")

        /// String of the corresponding method in `Terminal`.
        pub def cursorBack(n: Int32): String =
            if (n <= 0) "" else csi("${n}D")

        /// String of the corresponding method in `Terminal`.
        pub def cursorTo(row: {row = Int32}, column: Int32): String =
            if (row#row < 0 or column < 0) "" else
            // ones could be ommited here for output brevity
            csi("${row#row+1};${column+1}H")

        /// String of the corresponding method in `Terminal`.
        pub def clearScreenAfterCursor(): String =
            // implicitely give argument 0
            csi("J")

        /// String of the corresponding method in `Terminal`.
        pub def clearScreenBeforeCursor(): String =
            csi("1J")

        /// String of the corresponding method in `Terminal`.
        pub def clearScreenAndReset(): String =
            csi("2J") + cursorTo(row = 0, 0)

        /// String of the corresponding method in `Terminal`.
        pub def clearLineAfterCursor(): String =
            // implicitely give argument 0
            csi("K")

        /// String of the corresponding method in `Terminal`.
        pub def clearLineBeforeCursor(): String =
            csi("1K")

        /// String of the corresponding method in `Terminal`.
        pub def clearLine(): String =
            csi("2K")

        /// String of the corresponding method in `Terminal`.
        pub def saveCursor(): String =
            csi("s")

        /// String of the corresponding method in `Terminal`.
        pub def restoreCursor(): String =
            csi("u")

    }

    def output(x: s): Unit \ Console with ToString[s] =
        do Console.print(ToString.toString(x))

    def csi(s: String): String = {
        let escapeByte = "\u001B";
        "${escapeByte}[${s}"
    }

}
