block-level on error undo, throw.

class TestGetRefCall inherits TestGet:

    constructor public TestGetRefCall( ):
        super("refCalls").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
