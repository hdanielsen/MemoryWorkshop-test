block-level on error undo, throw.

class TestGetBenefits inherits TestGet:

    constructor public TestGetBenefits( ):
        super("benefits").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
