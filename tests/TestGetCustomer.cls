block-level on error undo, throw.

class TestGetCustomer inherits TestGet:

    constructor public TestGetCustomer( ):
        super("customers").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
