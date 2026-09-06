 
 /*------------------------------------------------------------------------
    File        : TestCustomer
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hdaniels
    Created     : Mon Apr 15 11:46:50 EDT 2019
    Notes       : 
  ----------------------------------------------------------------------*/

 

block-level on error undo, throw.

using Ccs.BusinessLogic.CommitScopeEnum from propath.
using OpenEdge.Core.Collections.IStringStringMap from propath.
using OpenEdge.Core.Collections.StringStringMap from propath.
using Pmfo.Core.BusinessLogic.GetDataRequest from propath.
using Pmfo.Core.BusinessLogic.GetDataTableRequest from propath.
using Pmfo.Core.BusinessLogic.IBusinessEntity from propath.
using Pmfo.Core.BusinessLogic.IGetDataRequest from propath.
using Pmfo.Core.BusinessLogic.IGetDataResponse from propath.
using Pmfo.Core.BusinessLogic.IGetDataTableRequest from propath.
using Pmfo.Core.BusinessLogic.IGetDataTableResponse from propath.
using Pmfo.Core.BusinessLogic.IUpdateDataRequest from propath.
using Pmfo.Core.BusinessLogic.UpdateDataRequest from propath.
using Pmfo.Core.Service.OperationHandler from propath.
using Pmfo.Tools.Test.TestBase from propath.
using Pmfo.Util.JsonUtil from propath.
using Progress.Json.ObjectModel.JsonObject from propath.

class TestImage inherits TestBase:

    
    {schema/item.i}
    define dataset dsItem for ttItem.
    
    @Before.
    method public override void Before():
        super:Before().
    end method.       
    
    
    @test.
    method public void Loadimage():
        define variable cFile as character no-undo
           init "gomexus-tackle-fishing-rod-8016641.jpg".
        
        define variable cPathedFile as character no-undo.
        cPathedFile = search("DataSource/Images/" + cFile).
        
        create ttItem.
        copy-lob file cPathedFile to ttItem.ItemImage.
        
        dataset dsItem:write-json("file","temp/image1.json",yes).
           
        
          
    end method. 
     
    @test.
    method public void Loadimage2():
        define variable oJson  as JsonObject no-undo.
        define variable cFile as character no-undo
           init "gomexus-tackle-fishing-rod-8016641.jpg".
        define variable mMem as memptr no-undo.
        define variable cPathedFile as character no-undo.
        cPathedFile = search("DataSource/Images/" + cFile).
        
        copy-lob file cPathedFile to mMEm.
        oJson = new JsonObject().
        oJson:Add("image", base64-encode(mMem)).
        oJson:writefile("temp/image2.json",yes).
           
        
          
    end method. 
      
   
end class.