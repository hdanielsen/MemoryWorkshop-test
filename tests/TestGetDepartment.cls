block-level on error undo, throw.

class TestGetDepartment inherits TestGet:

    constructor public TestGetDepartment( ):
        super("departments").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
