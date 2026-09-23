block-level on error undo, throw.

using Progress.Json.ObjectModel.JsonObject from propath.
using OpenEdge.Core.Assert from propath.
using Progress.Profiler.MemoryProfiler from propath.

class TestUpdateSupplier inherits TestUpdate:

    define variable JsonPosted as JsonObject no-undo.

    constructor public TestUpdateSupplier( ):
        super("suppliers").
    end constructor.
    
    @Test.
    method public void TestPost(  ):
        JsonPosted = PostData().
    end method.
    
    @Test.
    method public void SnapShotBegin():
        pause 0.5.
        MemoryProfiler:TakeSnapShot("afterPostSupplier").
    end method.     
    
    @Test.
    method public void TestDelete(  ):
        if valid-object(JsonPosted) then
            DeleteData(JsonPosted).
        else
            Assert:isTrue(false,"Valid Json Object to Delete").
    end method.
    
    @Test.
    method public void SnapShotEnd():
        pause 0.5.
        MemoryProfiler:TakeSnapShot("afterDeleteSupplier").
    end method.     

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    @After.
    method public void testAfter(  ):  
        delete object JsonPosted no-error. 
    end method.    
    
end class.
