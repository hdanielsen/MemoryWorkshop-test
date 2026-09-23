block-level on error undo, throw.

using Progress.Json.ObjectModel.JsonObject from propath.
using OpenEdge.Core.Assert from propath.
using Progress.Profiler.MemoryProfiler from propath.

class TestUpdateOrder inherits TestUpdate:

    define variable JsonPosted as JsonObject no-undo.

    constructor public TestUpdateOrder( ):
        super("orders").
    end constructor.
    
    @Test.
    method public void SnapShotBeforePost():
        MemoryProfiler:TakeSnapShot("beforePost").
    end method.     
       
    
    @Test.
    method public void TestPost(  ):
        JsonPosted = PostData().
    end method.

    @Test.
    method public void SnapShotAfterPost():
        MemoryProfiler:TakeSnapShot("AfterPost").
    end method.     
    

    @Test.
    method public void TestDelete(  ):
        if valid-object(JsonPosted) then
            DeleteData(JsonPosted).
        else
            Assert:isTrue(false,"Valid Json Object to Delete").
    end method.
    
    @Test.
    method public void SnapShotAfterDelete():
        MemoryProfiler:TakeSnapShot("afterDelete").
    end method.     
    
    
    @After. // delete json in case profiler is used
    method public void testAfter(  ):  
        delete object JsonPosted no-error. 
    end method.    
        
end class.
