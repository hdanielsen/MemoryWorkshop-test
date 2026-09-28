 
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

using OpenEdge.Core.Collections.IStringStringMap from propath.
using OpenEdge.Core.Collections.StringStringMap from propath.
using Pmfo.Core.BusinessLogic.IBusinessEntity from propath.
using Pmfo.Core.Service.OperationHandler from propath.
using Pmfo.Tools.Test.TestBase from propath.
using Progress.Json.ObjectModel.JsonObject from propath.
using Progress.Profiler.MemoryProfiler from propath.

class TestCustomerPage inherits TestBase:
    
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
  
end class.