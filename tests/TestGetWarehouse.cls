block-level on error undo, throw.

class TestGetWarehouse inherits TestGet:

    constructor public TestGetWarehouse( ):
        super("warehouses").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
