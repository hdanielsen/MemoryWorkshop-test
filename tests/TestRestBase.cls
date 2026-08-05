 
 /*------------------------------------------------------------------------
    File        : TestRestBase
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hdaniels
    Created     : Wed Aug 05 05:02:46 EDT 2026
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
using Pmfo.Tools.Test.ErrorHandler from propath.
using Pmfo.Util.RestClient from propath.
using Pmfo.Util.FileIO from propath.
using OpenEdge.Net.HTTP.IHttpResponse from propath.
using OpenEdge.Net.URI from propath.
using Progress.Json.ObjectModel.JsonObject from propath.
using OpenEdge.Core.Assert from propath.
using OpenEdge.Core.Collections.IMap from propath.
using OpenEdge.Core.Collections.Map from propath.
using OpenEdge.Core.String from propath.

block-level on error undo, throw.

class TestRestBase: 
    {Pmfo/Util/filedata.i}
    
    define protected property JsonMap as IMap no-undo 
         get():
             if not valid-object(JsonMap) then
                 JsonMap = new Map().
             return JsonMap.    
         end.
         set.
  
    define protected property RestClient as RestClient no-undo get. set.
    define protected property ErrorHandler as ErrorHandler  no-undo 
       get():
           if not valid-object(ErrorHandler) then 
               ErrorHandler = new ErrorHandler(). 
               
           return ErrorHandler.    
       end. 
       set.
     define protected property FileIo as FileIO no-undo 
        get():
            if not valid-object(FileIO) then
                FileIO =  new FileIO().
            return FileIO.    
        end.
        set.
     
    method public void deleteTempFiles(pcMethod as char):  
        file-info:file-name = "Temp". 
        current-window:width = 300.
        if file-info:full-pathname <> ? then
        do:
            fileio:getFiles(file-info:full-pathname, output table fileData).  
            for each fileData with width 300:
               if filedata.fileType = "text/json" and fullName matches substitute("*-&1-*",pcMethod) then
                   os-delete value(filedata.fullPath) .
                 
            end.    
        end.
    end method.  
            
    method protected JsonObject ProcessResponse(pcMethod as character,pcResource as character,oResponse as IHttpResponse, pUri  as URI):
        define variabl oJsonObject as JsonObject no-undo.
        define variable cSuffix as character no-undo.
        define variable cprefix as character no-undo. 
        
        cPrefix = substitute("&1-&2",
                             iso-date(today),
                             replace(string(time,"HH:MM"),":","")
                             ).
        if oResponse:StatusCode <> 200 and oResponse:StatusCode <> 204 then      
            cSuffix = "-error".
        
        if type-of(oResponse:Entity,JsonObject) then do: 
            oJsonObject = cast(oResponse:Entity,JsonObject).
         
            oJsonObject:WriteFile(substitute("Temp/&1-&2-&3&4.json",
                                             cPrefix,
                                             pcMethod,
                                             pcResource,
                                             cSuffix), 
                                  yes).   
        end.                            
        else if oResponse:StatusCode <> 204 then
            Assert:IsTrue(false,"Response is JSON").
                 
        if oResponse:StatusCode <> 200 and oResponse:StatusCode <> 204 then do:    
            if valid-object(oJsonObject) then do on error undo,leave:
                ErrorHandler:DisplayError(oJsonObject,substitute("&1 &2",pcMethod,pUri:ToString())).
            end.    
        end.
        
        // store in mao to use in delete
        if pcMethod = "POST"  then 
        do: 
           if oJsonObject:Has("response") then 
               oJsonObject = oJsonObject:GetJsonObject("response").
            
           JsonMap:Put(new String(pcResource), oJsonObject) . 
            
        end.
        Assert:IsTrue(oResponse:StatusCode = 200 or oResponse:StatusCode = 204 ,"Response status is 200 or 204").
        
        return oJsonObject.
    end method.  
     
end class.