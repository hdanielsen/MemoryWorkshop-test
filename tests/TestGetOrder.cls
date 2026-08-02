block-level on error undo, throw.

class TestGetOrder inherits TestGet:

    constructor public TestGetOrder( ):
        super("orders").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
