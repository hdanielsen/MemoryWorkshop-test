block-level on error undo, throw.

class TestGetFamily inherits TestGet:

    constructor public TestGetFamily( ):
        super("families").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
