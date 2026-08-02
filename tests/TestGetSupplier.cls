block-level on error undo, throw.

class TestGetSupplier inherits TestGet:

    constructor public TestGetSupplier( ):
        super("suppliers").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
