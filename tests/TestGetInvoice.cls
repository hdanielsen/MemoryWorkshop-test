block-level on error undo, throw.

class TestGetInvoice inherits TestGet:

    constructor public TestGetInvoice( ):
        super("invoices").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
