 
 /*------------------------------------------------------------------------
    File        : TestAddress
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hdaniels
    Created     : Mon Apr 15 11:46:50 EDT 2019
    Notes       : 
  ----------------------------------------------------------------------*/

 

block-level on error undo, throw.

using OpenEdge.Core.Assert from propath.
using OpenEdge.Core.Collections.IStringStringMap from propath.
using OpenEdge.Core.Collections.StringStringMap from propath.
using Pmfo.Core.BusinessLogic.GetDataRequest from propath.
using Pmfo.Core.BusinessLogic.GetDataTableRequest from propath.
using Pmfo.Core.BusinessLogic.IBusinessEntity from propath.
using Pmfo.Core.BusinessLogic.IGetDataRequest from propath.
using Pmfo.Core.BusinessLogic.IGetDataResponse from propath.
using Pmfo.Core.BusinessLogic.IGetDataTableRequest from propath.
using Pmfo.Core.BusinessLogic.IGetDataTableResponse from propath.
using Pmfo.Core.BusinessLogic.IQueryDefinition from propath.
using Pmfo.Core.BusinessLogic.QuerySortEntry from propath.
using Pmfo.Core.Service.OperationHandler from propath.
using Pmfo.Tools.Test.TestBase from propath.
using Progress.Json.ObjectModel.JsonArray from propath.
using Progress.Json.ObjectModel.JsonObject from propath.
using Progress.Profiler.MemoryProfiler from propath.

class TestAddress inherits TestBase:

    
    {schema/address.i}
    
    @Before.
    method public override void Before():
        super:Before().
    end method.       
    
   // @Test.
    method public void SnapShotBeforeBE():        
        MemoryProfiler:TakeSnapShot("BeforeAddress").
        pause 1.
    end method.     
     
    
  //  @Test. 
    method public void ReadAddressWithBE(  ):  
        define variable oBe               as IBusinessEntity no-undo.
        define variable hDataset          as handle no-undo.
        define variable oJson             as JsonObject no-undo.
        define variable oJsonOrders       as JsonObject no-undo.
        define variable oRequest          as IGetDataRequest       no-undo.
        define variable oResponse         as IGetDataResponse      no-undo.
        define variable oTableRequest     as IGetDataTableRequest  no-undo.
        define variable oTableResponse    as IGetDataTableResponse no-undo.
        define variable oQueryDefinition  as IQueryDefinition      no-undo.
        define variable i                 as integer no-undo.
           
        oBe = GetBE("addresses").
        oBe:getDataset(output dataset-handle hDataset).
        oRequest = new GetDataRequest().
        do i = 1 to hDataset:num-buffers:
            oTableRequest =  new GetDataTableRequest(hDataset:get-buffer-handle(i):table-handle).
            if i = 1 then do:
               oTableRequest:SetQuerySort(new QuerySortEntry("address")).
               oTableRequest:NumRecords = 100.
           
            end.    
            oRequest:AddTableRequest(oTableRequest).  
            leave.            
        end.         
        
        oResponse = oBe:GetData(oRequest,output dataset-handle hdataset by-reference).
    
        MemoryProfiler:TakeSnapShot("ActiveBe").
    
        hDataset:write-json ("file","temp/read-address.json",yes).  
       
        
        return.
        catch e as Progress.Lang.Error :
            ShowErrorsInWindow = true.
            HandleError(e).    
        end catch. 
    end method.
    
    @Test. 
    method public void GetAddressService(  ):  
        define variable oBe               as IBusinessEntity no-undo.
        define variable qmap              as IStringStringMap no-undo. 
        define variable oResponse         as JsonObject no-undo.
        define variable oMap              as StringStringMap no-undo.
        define variable oJson             as JsonObject no-undo.
        define variable oJsonOrders       as JsonObject no-undo.    
        
        oBe = GetBE("addresses").
        oMap = new StringStringMap().
        oMap:put("orderBy","address").
        oMap:put("filter","address contains 'rue' and country eq 'canada'").
        oMap:put("top","100").
        
        oResponse = OperationHandler:ExecuteRead("GET",
                                                 "http://10.0.0.198:8080/minster/web/api/", 
                                                 "addresses",
                                                 oMap, 
                                                 oBe).
         
        oResponse:WriteFile("temp/get-addresses.json",true).
       
        return.
        catch e as Progress.Lang.Error :
           ShowErrorsInWindow = false.
           HandleError(e).    
        end catch. 
    end method.  
    
 //   @Test.
    method public void SnapShotAfter():
        pause 1.
        MemoryProfiler:TakeSnapShot("afterGetAddress").
    end method.     
     
 
    
  
end class.