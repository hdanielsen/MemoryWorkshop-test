block-level on error undo, throw.

class TestGetSalesRepQuota inherits TestGet:

    constructor public TestGetSalesRepQuota( ):
        super("salesRepQuotas").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
