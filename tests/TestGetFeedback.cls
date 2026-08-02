block-level on error undo, throw.

class TestGetFeedback inherits TestGet:

    constructor public TestGetFeedback( ):
        super("feedbacks").
    end constructor.

    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.
end class.
