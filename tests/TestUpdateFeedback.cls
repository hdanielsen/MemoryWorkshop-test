block-level on error undo, throw.

using Progress.Json.ObjectModel.JsonObject from propath.
using OpenEdge.Core.Assert from propath.
class TestUpdateFeedback inherits TestUpdate:

    define variable JsonPosted as JsonObject no-undo.

    constructor public TestUpdateFeedback( ):
        super("feedbacks").
    end constructor.

    @Test.
    method public void TestPost(  ):
        JsonPosted = PostData().
    end method.

    @Test.
    method public void TestDelete(  ):
        if valid-object(JsonPosted) then
            DeleteData(JsonPosted).
        else
            Assert:isTrue(false,"Valid Json Object to Delete").
    end method.

end class.
