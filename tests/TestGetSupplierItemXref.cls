block-level on error undo, throw.

class TestGetSupplierItemXref inherits TestGet:

    constructor public TestGetSupplierItemXref( ):
        super("supplierItemXrefs").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
