 
 /*------------------------------------------------------------------------
    File        : TestCustomer
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hdaniels
    Created     : Sun Aug 02 08:27:40 EDT 2026
    Notes       : 
  ----------------------------------------------------------------------*/


block-level on error undo, throw.

using OpenEdge.Core.Collections.IStringStringMap from propath.
using OpenEdge.Core.Collections.StringStringMap from propath.
using Pmfo.Core.BusinessLogic.IBusinessEntity from propath.
using Pmfo.Core.BusinessLogic.IGetDataRequest from propath.
using Pmfo.Core.BusinessLogic.IGetDataResponse from propath.
using Pmfo.Core.Error.ApplicationError from propath.
using Pmfo.Core.Service.IClientGetRequest from propath.
using Pmfo.Core.Service.OperationHandler from propath.
using Pmfo.Util.JsonUtil from propath.
using Progress.Json.ObjectModel.JsonObject from propath.
using Pmfo.Tools.Test.TestBase from propath.

class TestUpdate inherits TestBase:
    
    define public    property Resource           as character no-undo  get. protected set.
    define protected property AddDateToFileName  as logical   no-undo  get. protected set.
  
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    constructor public TestUpdate (pcResource as char  ):
        super ().
        Resource = pcResource.
    end constructor.

   
    method protected JsonObject PostData(  ):  
        define variable oBe               as IBusinessEntity no-undo.
        define variable oResponse         as JsonObject no-undo.
        define variable oMap as StringStringMap no-undo.
        define variable cprefix as character no-undo. 
        define variable oJson as JsonObject no-undo.
     
        oBe = GetBE(Resource).
        oJson = LoadJson(substitute ("data/post-&1.json",Resource)). 
        oMap = new StringStringMap().
        oResponse = OperationHandler:ExecuteUpdate(
                                              "POST",
                                              oJson,
                                              "http://10.0.0.198:8080/minster/web/api", 
                                              Resource,
                                              oMap,
                                              oBe).
        if AddDateToFileName then                                      
            cPrefix = substitute("&1-&2-",
                                 iso-date(today),
                                 replace(string(time,"HH:MM"),":","")
                                 ).
        oResponse:WriteFile(subst("temp/&1posted-&2.json",cPrefix,Resource),true).
        
        return oResponse.
        catch e as Progress.Lang.Error :
           Showerrorsinwindow = true.
           HandleError(e).    
        end catch. 
    end method.
    
    method protected void DeleteData(  ):
        define variable oBe               as IBusinessEntity no-undo.
        define variable oResponse         as JsonObject no-undo.
        define variable oMap as StringStringMap no-undo.
        define variable cprefix as character no-undo. 
        define variable oJson as JsonObject no-undo.
     
        oBe = GetBE(Resource).
        file-info:file-name = substitute ("data/delete-&1.json",Resource). 
        if file-info:full-pathname > "" then 
           oJson = JsonUtil:ReadJsonFile( file-info:full-pathname).
        if not valid-object(oJson) then 
            undo, throw new ApplicationError(subst("No DELETE Json found for '&1'",Resource)).
        oMap = new StringStringMap().
        oResponse = OperationHandler:ExecuteUpdate(
                                              "DELETE",
                                              oJson,
                                              "http://10.0.0.198:8080/minster/web/api", 
                                              Resource,
                                              oMap,
                                              oBe).
        if valid-object(oResponse) then do:                                      
            cPrefix = substitute("&1-&2",
                                 iso-date(today),
                                 replace(string(time,"HH:MM"),":","")
                                 ).
            oResponse:WriteFile(subst("temp/&1-deleted-&2.json",cPrefix,Resource),true).
        
        end.
        catch e as Progress.Lang.Error :
           Showerrorsinwindow = true.
           HandleError(e).    
        end catch. 
    end method. 
    
    method protected void DeleteData( pJson as JsonObject ):  
        define variable oBe               as IBusinessEntity no-undo.
        define variable hDataset          as handle no-undo.
         define variable oResponse         as JsonObject no-undo.
        define variable oMap as StringStringMap no-undo.
         
     
        oBe = GetBE(Resource).
       
        oMap = new StringStringMap().
        if pJson:Has("response") then 
            pJson = pJson:GetJsonObject("response").
        OperationHandler:ExecuteUpdate(
                                      "DELETE",
                                      pJson,
                                      "http://10.0.0.198:8080/minster/web/api", 
                                      Resource,
                                      oMap,
                                      oBe).
         
         
        catch e as Progress.Lang.Error :
           Showerrorsinwindow = true.
           HandleError(e).    
        end catch. 
    end method.
end class.