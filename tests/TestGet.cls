 
 /*------------------------------------------------------------------------
    File        : TestCustomer
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hdaniels
    Created     : Sun Aug 02 08:27:40 EDT 2026
    Notes       : 
  ----------------------------------------------------------------------*/


using Pmfo.Core.BusinessLogic.IBusinessEntity from propath.
using OpenEdge.Core.Collections.IStringStringMap from propath.
using Pmfo.Core.Service.IClientGetRequest from propath.
using Pmfo.Core.BusinessLogic.IGetDataRequest from propath.
using Pmfo.Core.BusinessLogic.IGetDataResponse from propath.
using Progress.Json.ObjectModel.JsonObject from propath.
using OpenEdge.Core.Collections.StringStringMap from propath.
using Pmfo.Tools.Test.TestBase from propath.

block-level on error undo, throw.

class TestGet inherits TestBase:
    
    define public    property Resource           as character no-undo  get. protected set.
    define protected property AddDateToFileName  as logical   no-undo  get. protected set.
    
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    constructor public TestGet (pcResource as char  ):
        super ().
        Resource = pcResource.
    end constructor.

   
    method public void TestGetData(  ):  
        define variable oBe               as IBusinessEntity no-undo.
        define variable hDataset          as handle no-undo.
        define variable qmap              as IStringStringMap no-undo. 
        define variable oClientGetRequest as IClientGetRequest   no-undo.
        define variable cservice          as character no-undo.
        define variable oGetDataRequest   as IGetDataRequest     no-undo.
        define variable oGetDataResponse  as IGetDataResponse no-undo.
        define variable oResponse         as JsonObject no-undo.
        define variable oMap as StringStringMap no-undo.
        define variable iTable as integer no-undo.
        define variable cprefix as character no-undo. 
        
        if AddDateToFileName then
            cPrefix = substitute("&1-&2-",
                                 iso-date(today),
                                 replace(string(time,"HH:MM"),":","")
                                 ).
        oBe = GetBE(Resource).
        
        oMap = new StringStringMap().
        oResponse = OperationHandler:ExecuteRead("GET", 
                                                 "http://10.0.0.198:8080/minster/web/api", 
                                                 Resource,
                                                 oMap,
                                                 oBe).
        
        oResponse:WriteFile(subst("temp/&1get-&2.json",cPrefix,Resource),true).
        
        return.
        catch e as Progress.Lang.Error :
           Showerrorsinwindow = true.
           HandleError(e).    
        end catch. 
    end method.
end class.