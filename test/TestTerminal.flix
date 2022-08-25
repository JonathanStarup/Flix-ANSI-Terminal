namespace TestTerminal {

    def output(x: s): Unit \ IO with ToString[s] =
        print(x)

    def outputLine(x: s): Unit \ IO with ToString[s] =
        println(x)

    def sleep(millis: Int64): Unit \ IO =
        import static java.lang.Thread.sleep(Int64): Unit \ IO;
        sleep(millis)

    def sleepTime(): Int64 = 1000i64

    pub def testCursorUp(): Unit \ IO =
        outputLine("Expected Line: <<<x>>>");
        outputLine("<<< >>>");
        output("   ");

        sleep(sleepTime());
        Terminal.cursorUp(1);
        sleep(sleepTime());

        output("x")

    pub def testCursorDown(): Unit \ IO =
        outputLine("Expected Line: <<<x>>>");
        outputLine("<<< >>>");
        output("   ");

        sleep(sleepTime());
        Terminal.cursorUp(2);
        sleep(sleepTime());
        Terminal.cursorDown(1);
        sleep(sleepTime());

        output("x")

    pub def testCursorForward(): Unit \ IO =
        outputLine("Expected Line: <<<x>>>");
        outputLine("<<< >>>");

        sleep(sleepTime());
        Terminal.cursorUp(1);
        sleep(sleepTime());
        Terminal.cursorForward(3);
        sleep(sleepTime());

        output("x")

    pub def testCursorBack(): Unit \ IO =
        outputLine("Expected Line: <<<x>>>");
        outputLine("<<< >>>");
        output("       ");

        sleep(sleepTime());
        Terminal.cursorUp(1);
        sleep(sleepTime());
        Terminal.cursorBack(4);
        sleep(sleepTime());

        output("x")

    pub def testCursorTo(): Unit \ IO =
        Terminal.clearScreenAndReset();
        sleep(sleepTime());
        outputLine("Expected Line: <<<x>>>");
        outputLine("<<< >>>");

        sleep(sleepTime());
        Terminal.cursorTo(row = 1, 3);
        sleep(sleepTime());

        output("x")

    pub def testClearScreenAfterCursor(): Unit \ IO =
        outputLine("Expected Line: <<<x>>>");
        outputLine("<<<x>>>######");
        outputLine("##########");

        sleep(sleepTime());
        Terminal.cursorUp(2);
        sleep(sleepTime());
        Terminal.cursorForward(7);
        sleep(sleepTime());
        Terminal.clearScreenAfterCursor();
        sleep(sleepTime())

    pub def testClearScreenBeforeCursor(): Unit \ IO =
        outputLine("Expected Line: <<<x>>>");
        outputLine("##########");
        outputLine("####<<<x>>>");

        sleep(sleepTime());
        Terminal.cursorUp(1);
        sleep(sleepTime());
        Terminal.cursorForward(3);
        sleep(sleepTime());
        Terminal.clearScreenBeforeCursor();
        sleep(sleepTime())

    pub def testClearScreenAndReset(): Unit \ IO =
        outputLine("Expected Line: <<<x>>>");
        outputLine("##########");
        outputLine("##########");

        sleep(sleepTime());
        Terminal.clearScreenAndReset();
        sleep(sleepTime());
        outputLine("<<<x>>>")

    pub def testClearLineAfterCursor(): Unit \ IO =
        outputLine("Expected Line: <<<x>>>");
        output("<<<x>>>#######");

        sleep(sleepTime());
        Terminal.cursorBack(7);
        sleep(sleepTime());
        Terminal.clearLineAfterCursor();
        sleep(sleepTime())

    pub def testClearLineBeforeCursor(): Unit \ IO =
        outputLine("Expected Line: <<<x>>>");
        output("#####<<<x>>>");

        sleep(sleepTime());
        Terminal.cursorBack(8);
        sleep(sleepTime());
        Terminal.clearLineBeforeCursor();
        sleep(sleepTime())

    pub def testClearLine(): Unit \ IO =
        outputLine("Expected Line: <<<x>>>");
        outputLine("<<<x>>>");
        output("######");

        sleep(sleepTime());
        Terminal.cursorBack(3);
        sleep(sleepTime());
        Terminal.clearLine();
        sleep(sleepTime())

    pub def testSaveAndRestore(): Unit \ IO =
        outputLine("Expected Line: <<<x>>>");
        output("<<<");
        Terminal.saveCursor();
        outputLine(" >>>");

        sleep(sleepTime());
        Terminal.restoreCursor();
        sleep(sleepTime());

        output("x")

}
