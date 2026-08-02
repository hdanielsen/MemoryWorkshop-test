block-level on error undo, throw.

class TestGetVacation inherits TestGet:

    constructor public TestGetVacation( ):
        super("vacations").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
