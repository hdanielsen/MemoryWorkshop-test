 
 /*------------------------------------------------------------------------
    File        : TestRestClient
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hdaniels
    Created     : Sun Aug 02 12:17:49 EDT 2026
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
using Pmfo.Util.RestClient from propath.
using OpenEdge.Net.URI from propath.
using OpenEdge.Net.UriSchemeEnum from propath.
using OpenEdge.Core.Collections.StringStringMap from propath.
using OpenEdge.Net.HTTP.IHttpResponse from propath.
using OpenEdge.Core.Assert from propath.
using System.Net.HttpStatusCode from assembly.
using Progress.Json.ObjectModel.JsonObject from propath.

block-level on error undo, throw.

class TestRestClient:
    
   define protected property RestClient as RestClient no-undo get. set.
    
     
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    @Setup.
    method public void Setup(  ):  
       RestClient = new RestClient(UriSchemeEnum:http,"localhost",8080,"/main/web/api").
    end method.
    
    @Test.
    method public void TestGetBenefits():
       executeGet("benefits").
    end method. 
    
    @Test.
    method public void TestGetBilltos():
       executeGet("billTOs").
    end method. 
    
    @Test.
    method public void TestGetBins():
       executeGet("bins").
    end method. 
    
    @Test.
    method public void TestGetCustomers():
       executeGet("customers").
    end method. 
    
    @Test.
    method public void TestGetDepartments():
       executeGet("departments").
    end method. 
    
    @Test.
    method public void TestGetEmployees():
       executeGet("employees").
    end method. 
    
    @Test.
    method public void TestGetFamilies():
       executeGet("families").
    end method. 
    
    @Test.
    method public void TestGetFeedbacks():
       executeGet("feedbacks").
    end method. 
    
    @Test.
    method public void TestGetInventoryTransactions():
       executeGet("inventoryTransactions").
    end method. 
    
    @Test.
    method public void TestGetInvoices():
       executeGet("invoices").
    end method. 
    
    @Test.
    method public void TestGetItems():
       executeGet("items").
    end method. 
    
    @Test.
    method public void TestGetLocalDefaults():
       executeGet("localdefaults").
    end method. 
    
    @Test.
    method public void TestGetOrders():
       executeGet("orders").
    end method. 
    
    @Test.
    method public void TestGetPurchaseOrders():
       executeGet("purchaseorders").
    end method. 
    
    @Test.
    method public void TestGetRefcalls():
       executeGet("refcalls").
    end method. 
    
    @Test.
    method public void TestGetSalesreps():
       executeGet("salesreps").
    end method. 
    
    @Test.
    method public void TestGetShipTos():
       executeGet("shipTos").
    end method. 
    
    @Test.
    method public void TestGetStates():
       executeGet("states").
    end method. 
    
    @Test.
    method public void TestGetSuppliers():
       executeGet("suppliers").
    end method. 
    
    @Test.
    method public void TestGetTimeSheets():
       executeGet("timesheets").
    end method. 
    
    @Test.
    method public void TestGetVacations():
       executeGet("vacations").
    end method. 
    
    @Test.
    method public void TestGetWarehouses():
       executeGet("warehouses").
    end method. 
    
    
    method protected void executeGet(pcResource as char):
       define variable oResponse       as IHttpResponse no-undo.
       oResponse = RestClient:executeGetRequest(pcResource).
       ProcessResponse("GET",pcResource,oResponse). 
    end method.    
    
    method protected void ProcessResponse(pcMethod as character,pcResource as character,oResponse as IHttpResponse):
        define variabl oJsonObject as JsonObject no-undo.
        define variable cSuffix as character no-undo.
       // Assert:IsTrue(oResponse:StatusCode = 200,"Status is 200").
        if oResponse:StatusCode <> 200 then      
           cSuffix = "-error".
            
        if type-of(oResponse:Entity,JsonObject) then do: 
            oJsonObject = cast(oResponse:Entity,JsonObject).
            oJsonObject:WriteFile(substitute("Temp/&1-&2&3.json",
                                             pcMethod,
                                             pcResource,
                                             cSuffix), 
                                  yes).     
        end.    
        else 
           Assert:IsTrue(false,"Response is JSON").
                 
         if oResponse:StatusCode <> 200 then     
            Assert:IsTrue(false,"Status is 200"). 
    end method.    
          
end class.