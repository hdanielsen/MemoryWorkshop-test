block-level on error undo, throw.

class TestGetOrderLine inherits TestGet:

    constructor public TestGetOrderLine( ):
        super("orderLines").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
