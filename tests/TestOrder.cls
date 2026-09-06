 
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

class TestOrder inherits TestBase:

    
    {schema/order.i}
    {schema/orderLine.i}
    
    @Before.
    method public override void Before():
        super:Before().
    end method.       
    
   // @Test. 
    method public void CreateOrderUsingBE(  ):  
        define variable oBe               as IBusinessEntity no-undo.
        define variable hDataset          as handle no-undo.
        define variable oJson             as JsonObject no-undo.
        define variable oJsonOrders       as JsonObject no-undo.
        define variable oUpdateRequest    as IUpdateDataRequest  no-undo.
        define variable i                 as integer no-undo.
           
        oBe = GetBE("orders").
        oJson =  JsonUtil:ReadJsonFile("data/post-orders.json").
       // oJsonOrders =  oJson:GetJsonArray("orders").
        oUpdateRequest = new UpdateDataRequest("ttOrder"). 
        oUpdateRequest:CommitScope = CommitScopeEnum:All.    
        oBe:getDataset(output dataset-handle hDataset).
         
        oJsonOrders = JsonUtil:WrapRequestForDataset(ojson, hDataset, "ttOrder").
        
        do i = 1 to hdataset:num-buffers:        
             hdataset:get-buffer-handle(i):table-handle:tracking-changes = true.
        end.
        hDataset:read-json ("JsonObject",oJsonOrders).  
        do i = 1 to hdataset:num-buffers:        
             hdataset:get-buffer-handle(i):table-handle:tracking-changes = false.
        end.
        
        oBe:UpdateData(input-output dataset-handle hdataset by-reference, oUpdateRequest).
        hDataset:write-json ("file","temp/posted-orders.json",yes).  
        
        return.
        catch e as Progress.Lang.Error :
             ShowErrorsInWindow = true.
             HandleError(e).    
        end catch. 
    end method.
    
    // @Test. 
    method public void DeleteOrderUsingBE(  ):  
        define variable oBe               as IBusinessEntity no-undo.
        define variable hDataset          as handle no-undo.
        define variable oJson             as JsonObject no-undo.
        define variable oUpdateRequest    as IUpdateDataRequest  no-undo.
        define variable i                 as integer no-undo.
        define variable hOrderTable       as handle no-undo. 
        define variable hOrderLineTable    as handle no-undo.
           
        oBe = GetBE("orders").
        oJson =  JsonUtil:ReadJsonFile("temp/posted-orders.json").
       // oJsonOrders =  oJson:GetJsonArray("orders").
        oUpdateRequest = new UpdateDataRequest("ttOrder"). 
        oUpdateRequest:CommitScope = CommitScopeEnum:All.    
        oBe:getDataset(output dataset-handle hDataset).
        
        hDataset:read-json ("JsonObject",oJson).  
         
        hOrderTable = hDataset:get-buffer-handle("ttOrder"):table-handle.
        DeleteOrderTable(input table-handle hOrderTable by-reference).
        
        hOrderLineTable = hDataset:get-buffer-handle("ttOrderLine"):table-handle.
        DeleteOrderLineTable(input table-handle hOrderLineTable by-reference).
        
        oBe:UpdateData(input-output dataset-handle hdataset by-reference, oUpdateRequest).
       
        return.
        catch e as Progress.Lang.Error :
             ShowErrorsInWindow = true.
             HandleError(e).    
        end catch. 
    end method.
    
     
  //  @Test.
    method public void PostOrder(  ):  
        define variable oBe               as IBusinessEntity no-undo.
        define variable qmap              as IStringStringMap no-undo. 
        define variable oResponse         as JsonObject no-undo.
        define variable oMap as StringStringMap no-undo.
        define variable oJson as JsonObject no-undo.
        oBe = GetBE("orders").
        ShowErrorsInWindow = true.
        oMap = new StringStringMap().
        oJson =  JsonUtil:ReadJsonFile("data/post-orders.json").
        oResponse = OperationHandler:ExecuteUpdate("POST",
                                                    oJson, 
                                                    "http://10.0.0.198:8080/minster/web/genesis", 
                                                    "orders",
                                                     oMap, 
                                                     oBe).
                                                     
        oResponse:WriteFile("temp/orders-afterpost.json",true).
        
    
        
     
        return.
        catch e as Progress.Lang.Error :
           HandleError(e).    
        end catch. 
    end method.
    
    
    // @Test. 
    method public void DeleteOrder(  ):  
        define variable oBe               as IBusinessEntity no-undo.
        define variable qmap              as IStringStringMap no-undo. 
        define variable oResponse         as JsonObject no-undo.
        define variable oMap as StringStringMap no-undo.
        define variable oJson as JsonObject no-undo.
        define variable oJsonOrders as JsonObject no-undo.
        
        oBe = GetBE("orders").
        ShowErrorsInWindow = true.
        oMap = new StringStringMap().
        oJson =  JsonUtil:ReadJsonFile("temp/orders-afterpost.json").
        oJsonOrders =  new JsonObject().
        oJsonOrders:Add("orders",oJson:GetJsonObject("response"):GetJsonArray("orders")).
        oResponse = OperationHandler:ExecuteUpdate("DELETE",
                                                    oJsonOrders, 
                                                    "http://10.0.0.198:8080/minster/web/genesis", 
                                                    "orders",
                                                     oMap, 
                                                     oBe).
         
        return.
        catch e as Progress.Lang.Error :
           HandleError(e).    
        end catch. 
    end method.
    
    
     @Test. 
    method public void ReadOrderPageWithBE(  ):  
        define variable oBe               as IBusinessEntity no-undo.
        define variable hDataset          as handle no-undo.
        define variable oJson             as JsonObject no-undo.
        define variable oJsonOrders       as JsonObject no-undo.
        define variable oRequest          as IGetDataRequest       no-undo.
        define variable oResponse         as IGetDataResponse      no-undo.
        define variable oTableRequest     as IGetDataTableRequest  no-undo.
        define variable oTableResponse    as IGetDataTableResponse no-undo.
        define variable i                 as integer no-undo.
           
        oBe = GetBE("orders").
        oBe:getDataset(output dataset-handle hDataset).
        oRequest = new GetDataRequest().
        oRequest:
        do i = 1 to hDataset:num-buffers:
            oTableRequest =  new GetDataTableRequest(hDataset:get-buffer-handle(i):table-handle).
            if i = 1 then do:
                oTableRequest:NumRecords = 20.
            end.    
            oRequest:AddTableRequest(oTableRequest).  
            leave. //  only order          
        end.         
        
        oResponse = oBe:GetData(oRequest,output dataset-handle hdataset by-reference).
        
        hDataset:write-json ("file","temp/get-orders.json",yes).  
       
        do i = 1 to extent(oResponse:TableResponses):
            if i = 1 then do:
                message 
                oResponse:TableResponses[i]:NextPagingContext
                view-as alert-box.
                
            end.    
            oRequest:AddTableRequest(new GetDataTableRequest(hDataset:get-buffer-handle(i):table-handle)).             
       
        end.         
       
        
        return.
        catch e as Progress.Lang.Error :
             ShowErrorsInWindow = true.
             HandleError(e).    
        end catch. 
    end method.
    
    
     @Test. 
    method public void GetOrderPage(  ):  
        define variable oBe               as IBusinessEntity no-undo.
        define variable qmap              as IStringStringMap no-undo. 
        define variable oResponse         as JsonObject no-undo.
        define variable oMap as StringStringMap no-undo.
        define variable oJson as JsonObject no-undo.
        define variable oJsonOrders as JsonObject no-undo.    
        
        oBe = GetBE("orders").
        oMap = new StringStringMap().
        
        oMap:put("top","20").
        
        oResponse = OperationHandler:ExecuteRead("GET",
                                                 "http://10.0.0.198:8080/minster/web/genesis", 
                                                 "orders",
                                                 oMap, 
                                                 oBe).
         
        oResponse:WriteFile("temp/get-orders.json",true).
        
     
        return.
        catch e as Progress.Lang.Error :
           ShowErrorsInWindow = true.
           HandleError(e).    
        end catch. 
    end method.  
    
    method protected void DeleteOrderTable(input table ttOrder):
        temp-table ttOrder:tracking-changes = true.
        for each ttOrder:
            delete ttOrder.
        end.     
        temp-table ttOrder:tracking-changes = false.
    end.    
    
    method protected void DeleteOrderLineTable(input table ttOrderLine):
        temp-table ttOrderLine:tracking-changes = true.
        for each ttOrderLine:
            delete ttOrderLine.
        end.     
        temp-table ttOrder:tracking-changes = false.
    end.    
     
   
end class.