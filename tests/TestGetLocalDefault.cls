block-level on error undo, throw.

class TestGetLocalDefault inherits TestGet:

    constructor public TestGetLocalDefault( ):
        super("localDefaults").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
