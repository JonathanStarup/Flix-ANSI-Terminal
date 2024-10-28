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

mod TestTerminal {
    import java.lang.Thread
    import java.lang.System

    use Console.run

    def output(x: t): Unit \ Console with ToString[t] =
        Console.print(ToString.toString(x))

    def outputln(x: t): Unit \ Console with ToString[t] =
        Console.println(ToString.toString(x))

    def sleep(millis: Int64): Unit \ IO =
        Thread.sleep(millis)

    def sleepTime(): Int64 = 1000i64

    def nextLineIsh(): Unit \ Console = {
        Terminal.cursorDown(1);
        outputln("")
    }

    pub def testCursorUp(): Unit \ IO = run(() -> {
        outputln("Expected Line: <<<x>>>");
        outputln("<<< >>>");
        output("   ");

        sleep(sleepTime());
        Terminal.cursorUp(1);
        sleep(sleepTime());

        output("x");
        nextLineIsh()
    })

    pub def testCursorDown(): Unit \ IO = run(() -> {
        outputln("Expected Line: <<<x>>>");
        outputln("<<< >>>");
        output("   ");

        sleep(sleepTime());
        Terminal.cursorUp(2);
        sleep(sleepTime());
        Terminal.cursorDown(1);
        sleep(sleepTime());

        output("x");
        nextLineIsh()
    })

    pub def testCursorForward(): Unit \ IO = run(() -> {
        outputln("Expected Line: <<<x>>>");
        outputln("<<< >>>");

        sleep(sleepTime());
        Terminal.cursorUp(1);
        sleep(sleepTime());
        Terminal.cursorForward(3);
        sleep(sleepTime());

        output("x");
        nextLineIsh()
    })

    pub def testCursorBack(): Unit \ IO = run(() -> {
        outputln("Expected Line: <<<x>>>");
        outputln("<<< >>>");
        output("       ");

        sleep(sleepTime());
        Terminal.cursorUp(1);
        sleep(sleepTime());
        Terminal.cursorBack(4);
        sleep(sleepTime());

        output("x");
        nextLineIsh()
    })

    pub def testCursorTo(): Unit \ IO = run(() -> {
        Terminal.clearScreenAndReset();
        sleep(sleepTime());
        outputln("Expected Line: <<<x>>>");
        outputln("<<< >>>");

        sleep(sleepTime());
        Terminal.cursorTo(row = 1, 3);
        sleep(sleepTime());

        output("x");
        nextLineIsh()
    })

    pub def testClearScreenAfterCursor(): Unit \ IO = run(() -> {
        outputln("Expected Line: <<<x>>>");
        outputln("<<<x>>>######");
        outputln("##########");

        sleep(sleepTime());
        Terminal.cursorUp(2);
        sleep(sleepTime());
        Terminal.cursorForward(7);
        sleep(sleepTime());
        Terminal.clearScreenAfterCursor();
        sleep(sleepTime());
        nextLineIsh()
    })

    pub def testClearScreenBeforeCursor(): Unit \ IO = run(() -> {
        outputln("Expected Line: <<<x>>>");
        outputln("##########");
        outputln("####<<<x>>>");

        sleep(sleepTime());
        Terminal.cursorUp(1);
        sleep(sleepTime());
        Terminal.cursorForward(3);
        sleep(sleepTime());
        Terminal.clearScreenBeforeCursor();
        sleep(sleepTime());
        nextLineIsh()
    })

    pub def testClearScreenAndReset(): Unit \ IO = run(() -> {
        outputln("Expected Line: <<<x>>>");
        outputln("##########");
        outputln("##########");

        sleep(sleepTime());
        Terminal.clearScreenAndReset();
        sleep(sleepTime());
        outputln("<<<x>>>");
        nextLineIsh()
    })

    pub def testClearLineAfterCursor(): Unit \ IO = run(() -> {
        outputln("Expected Line: <<<x>>>");
        output("<<<x>>>#######");

        sleep(sleepTime());
        Terminal.cursorBack(7);
        sleep(sleepTime());
        Terminal.clearLineAfterCursor();
        sleep(sleepTime());
        nextLineIsh()
    })

    pub def testClearLineBeforeCursor(): Unit \ IO = run(() -> {
        outputln("Expected Line: <<<x>>>");
        output("#####<<<x>>>");

        sleep(sleepTime());
        Terminal.cursorBack(8);
        sleep(sleepTime());
        Terminal.clearLineBeforeCursor();
        sleep(sleepTime());
        nextLineIsh()
    })

    pub def testClearLine(): Unit \ IO = run(() -> {
        outputln("Expected Line: <<<x>>>");
        outputln("<<<x>>>");
        output("######");

        sleep(sleepTime());
        Terminal.cursorBack(3);
        sleep(sleepTime());
        Terminal.clearLine();
        sleep(sleepTime());
        nextLineIsh()
    })

    pub def testSaveAndRestore(): Unit \ IO = run(() -> {
        outputln("Expected Line: <<<x>>>");

        // avoid scrolling
        outputln("");
        Terminal.cursorUp(1);

        output("<<<");
        Terminal.saveCursor();
        outputln(" >>>");

        sleep(sleepTime());
        Terminal.restoreCursor();
        sleep(sleepTime());

        output("x");
        nextLineIsh()
    })

}
