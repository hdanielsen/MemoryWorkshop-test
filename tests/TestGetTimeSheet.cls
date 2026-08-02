block-level on error undo, throw.

class TestGetTimeSheet inherits TestGet:

    constructor public TestGetTimeSheet( ):
        super("timeSheets").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
