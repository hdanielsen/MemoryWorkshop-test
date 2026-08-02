block-level on error undo, throw.

class TestGetPurchaseOrder inherits TestGet:

    constructor public TestGetPurchaseOrder( ):
        super("purchaseOrders").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
