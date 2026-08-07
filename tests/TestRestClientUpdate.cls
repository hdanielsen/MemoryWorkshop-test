 
 /*------------------------------------------------------------------------
    File        : TestRestClient
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hdaniels
    Notes       : 
  ----------------------------------------------------------------------*/


block-level on error undo, throw.

using OpenEdge.Core.Assert from propath.
using OpenEdge.Net.HTTP.IHttpResponse from propath.
using OpenEdge.Net.UriSchemeEnum from propath.
using Pmfo.Util.JsonUtil from propath.
using Pmfo.Util.RestClient from propath.
using Progress.Json.ObjectModel.JsonObject from propath.
using OpenEdge.Core.Collections.IMap from propath.
using Progress.Json.ObjectModel.JsonArray from propath.
using OpenEdge.Core.Collections.Map from propath.
using OpenEdge.Core.String from propath.
using Progress.Lang.Object from propath.

class TestRestClientUpdate inherits TestRestBase:
   {Pmfo/Util/filedata.i}

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
     
    
    @Before.
    method public void Before   (  ):  
        deleteTempFiles("POST").
        deleteTempFiles("DELETE").
        RestClient = new RestClient(UriSchemeEnum:http,"localhost",8080,"/main/web/api").
    end method.
 
    @Test.
    method public void TestPostBenefits():
        executePost("benefits").
    end method. 
    
    @Test.
    method public void TestPostBins():
        executePost("bins").
    end method. 
 
    @Test.
    method public void TestPostCustomers():
        executePost("customers").
    end method. 
    
    @Test.
    method public void TestPostDepartments():
        executePost("departments").
    end method. 
    
    @Test.
    method public void TestPostEmployees():
        executePost("employees").
    end method.
    
    @Test.
    method public void TestPostFamilies():
        executePost("families").
    end method. 
    
    @Test.
    method public void TestPostItems():
        executePost("items").
    end method. 
    
    @Test.
    method public void TestPostLocalDefaults():
        executePost("localDefaults").
    end method. 
    
    @Test.
    method public void TestPostOrders():
        executePost("orders").
    end method.
    
    @Test.
    method public void TestPostPurchaseOrders():
        executePost("purchaseOrders").
    end method.
    
    @Test.
    method public void TestPostRefCalls():
        executePost("refCalls").
    end method. 
    
    @Test.
    method public void TestDeleteBenefits():
        executeDelete("benefits").
    end method.  
    
    @Test.
    method public void TestDeleteBins():
        executeDelete("bins").
    end method.
    
    @Test.
    method public void TestDeleteCustomers():
        executeDelete("customers").
    end method. 
    
    @Test.
    method public void TestDeleteDepartments():
        executeDelete("departments").
    end method. 
    
    @Test.
    method public void TestDeleteEmployees():
        executeDelete("employees").
    end method.
    
    @Test.
    method public void TestDeleteFamilies():
        executeDelete("families").
    end method. 
    
    @Test.
    method public void TestDeleteItems():
        executeDelete("items").
    end method. 
    
    @Test.
    method public void TestDeleteLocalDefaults():
        executeDelete("localDefaults").
    end method. 
    
    @Test.
    method public void TestDeleteOrders():
        executeDelete("orders").
    end method.
    
    @Test.
    method public void TestDeletePurchaseOrders():
        executeDelete("purchaseOrders").
    end method.
    
    @Test.
    method public void TestDeleteRefCalls():
        executeDelete("refCalls").
    end method.
     
    method protected void executePost(pcResource as char):
       define variable oJson         as JsonObject no-undo. 
       define variable oResponseJson as JsonObject no-undo. 
       define variable oResponseArray as JsonArray no-undo. 
       define variable oResponse as IHttpResponse no-undo.
       define variable cFile     as character no-undo.
       file-info:file-name = substitute ("data/post-&1.json",pcResource). 
       if file-info:full-pathname > "" then 
          oJson = JsonUtil:ReadJsonFile( file-info:full-pathname).
       else 
          Assert:IsTrue(false,"Post JSON exists").
       oResponse = RestClient:executePostRequest(pcResource,oJson).
      
       oResponseJson = ProcessResponse("POST",pcResource,oResponse,RestClient:uri). 
       
      
    end method.  
    
    method protected void executeDelete(pcResource as character):
       define variable oResponse as IHttpResponse no-undo.
       define variable oObject as Object no-undo. 
       
       oObject = JsonMap:Get(new String(pcResource)) .
       
       if type-of(oObject,JsonObject) then do:
          oResponse = RestClient:executeDeleteRequest(pcResource,cast(oObject,JsonObject) ).
      
          ProcessResponse("DELETE",pcResource,oResponse,RestClient:uri). 
       end.
       else 
          Assert:IsTrue(false,"JSON for delete exists"). 
    end method.      
    
    
     method protected void executeDeleteFromData(pcResource as character):
       define variable oResponse as IHttpResponse no-undo.
       define variable oJson         as JsonObject no-undo. 
       define variable cFile     as character no-undo.
       file-info:file-name = substitute ("data/delete-&1.json",pcResource). 
       if file-info:full-pathname > "" then 
          oJson = JsonUtil:ReadJsonFile( file-info:full-pathname).
       else 
          Assert:IsTrue(false,"Delete JSON exists").
       
        
          oResponse = RestClient:executeDeleteRequest(pcResource,oJson).
      
          ProcessResponse("DELETE",pcResource,oResponse,RestClient:uri). 
       . 
    end method.           
end class.