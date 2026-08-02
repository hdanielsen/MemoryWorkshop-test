block-level on error undo, throw.

class TestGetPurchaseOrderLine inherits TestGet:

    constructor public TestGetPurchaseOrderLine( ):
        super("purchaseOrderLines").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
