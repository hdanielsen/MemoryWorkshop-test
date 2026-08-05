 
 /*------------------------------------------------------------------------
    File        : TestRestClient
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hdaniels
    Notes       : 
  ----------------------------------------------------------------------*/


block-level on error undo, throw.

using OpenEdge.Net.HTTP.IHttpResponse from propath.
using OpenEdge.Net.UriSchemeEnum from propath.
using Pmfo.Util.RestClient from propath.

class TestRestClient inherits TestRestBase:
   
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    @Before.
    method public void Before   (  ):  
       deleteTempFiles("GET").
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
    method public void TestGetOrderLines():
       executeGet("orderLines").
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
    method public void TestGetSalesrepQuotas():
       executeGet("salesrepQuotas").
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
       ProcessResponse("GET",pcResource,oResponse,RestClient:uri). 
    end method.    
    
      
          
end class.