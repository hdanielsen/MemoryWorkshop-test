block-level on error undo, throw.

class TestGetSalesRep inherits TestGet:

    constructor public TestGetSalesRep( ):
        super("salesReps").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
