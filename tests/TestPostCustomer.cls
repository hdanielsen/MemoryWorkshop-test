block-level on error undo, throw.

using Progress.Json.ObjectModel.JsonObject from propath.

class TestPostCustomer inherits TestUpdate :
    define variable JsonPosted as JsonObject  no-undo.
    constructor public TestPostCustomer( ):
        super("customers").
    end constructor.

    @Test.
    method public void TestPost(  ):
        JsonPosted = PostData().
    end method.

    @Test.
    method public void TestDelete(  ):
        DeleteData(JsonPosted).
    end method.

end class.
