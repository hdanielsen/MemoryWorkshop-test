block-level on error undo, throw.

class TestGetBin inherits TestGet:

    constructor public TestGetBin( ):
        super("bins").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
