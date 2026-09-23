 
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

class TestCustomerSort inherits TestBase:

    
    {schema/customer.i}
    
    @Before.
    method public override void Before():
        super:Before().
    end method.       
    
    
    @Test.
    method public void SnapShotBefore():
        MemoryProfiler:TakeSnapShot("BeforeGetCustomerPage").
        
    end method.     
       
    @Test. 
    method public void GetCustomerPage(  ):  
        define variable oBe               as IBusinessEntity no-undo.
        define variable qmap              as IStringStringMap no-undo. 
        define variable oResponse         as JsonObject no-undo.
        define variable oMap as StringStringMap no-undo.
        define variable oJson as JsonObject no-undo.
        define variable oJsonOrders as JsonObject no-undo.    
        
        oBe = GetBE("customers").
        oMap = new StringStringMap().
        
        oMap:put("top","10").
        oMap:put("orderBy","name").
        
        oResponse = OperationHandler:ExecuteRead("GET",
                                                 "http://10.0.0.198:8080/minster/web/api/", 
                                                 "customers",
                                                 oMap, 
                                                 oBe).
         
        oResponse:WriteFile("temp/get-customers.json",true).
        CheckResponseSort(oResponse:GetJsonObject("response"):GetJsonArray("customers"),"naME",10,true).
        return.
        catch e as Progress.Lang.Error :
           ShowErrorsInWindow = false.
           HandleError(e).    
        end catch. 
    end method.  
    
    
    @Test.
    method public void SnapShotAfter():
        
        MemoryProfiler:TakeSnapShot("AfterGetCustomerPage").
    end method.     
     
    
    method protected integer GetIntPropertyValueInArray(pJsonArray as JsonArray,piProp as character, piValue as integer):
        define variable i as integer no-undo.
        do i = 1 to pJsonArray:length: 
           if pJsonArray:GetJsonObject(i):GetInteger("custNum") = piValue then 
              return i. 
        end.    
        return 0.
    end method.
    
    method protected void CheckResponseSort(pJsonArray as JsonArray, pcSort as character, piNumRecs as integer,plDisplay as logical):
        define variable i as integer no-undo.
        define variable iCount as integer no-undo.
        define variable hQuery as handle no-undo.
        define variable iMismatches as integer no-undo.
        define variable lNotinbatch as logical no-undo.
        define variable iPostionInJson as integer no-undo label "Pos in Json".
        create query hQuery.
        hQuery:add-buffer(buffer customer:handle).
        hQuery:query-prepare(substitute ("for each &1 by &2","customer",pcSort)).
        hQuery:query-open().
        hQuery:get-first.
        
        current-window:width = 200.
        
        do while avail Customer with down width 200:
           iCount = iCount + 1.
           if Customer.CustNum <> pJsonArray:GetJsonObject(iCount):GetInteger("custNum") then 
               iMismatches = IMisMatches + 1. 
               
           iPostionInJson = GetIntPropertyValueInArray(pJsonArray, "Custnum",Customer.CustNum).
           if iPostionInJson = 0 then    
               lNotinbatch = true.
           
           
           if plDisplay then do:
              display 
                  iCount format ">>9"
                  iPostionInJson format ">>9"
                  Customer.CustNum Customer.Name
                  pJsonArray:GetJsonObject(iCount):GetInteger("custNum") format ">>>>>9"
                  pJsonArray:GetJsonObject(iCount):GetCharacter("name")  format "x(35)"
                  .
              down.
           end.   
           
           if iCount >= piNumRecs then leave.    
           hQuery:get-next.
           
                
        end.        
        Assert:ISTrue(iMismatches = 0,"Number of mismatches is 0").
        Assert:IsTrue(lNotinbatch = false,"in batch").
        
        finally:
            delete object hQuery.
        end finally.
                        
    end method.
    
  
end class.