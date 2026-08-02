block-level on error undo, throw.

class TestGetInventoryTransaction inherits TestGet:

    constructor public TestGetInventoryTransaction( ):
        super("inventoryTransactions").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
