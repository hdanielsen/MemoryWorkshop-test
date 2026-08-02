block-level on error undo, throw.

class TestGetBillTo inherits TestGet:

    constructor public TestGetBillTo( ):
        super("billTos").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
