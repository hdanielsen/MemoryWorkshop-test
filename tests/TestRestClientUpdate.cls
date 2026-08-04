 
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
using Pmfo.Util.FileIO from propath.
using Pmfo.Util.JsonUtil from propath.

block-level on error undo, throw.

class TestRestClientUpdate:
    {Pmfo/Util/filedata.i}
   define protected property RestClient as RestClient no-undo get. set.
    
    define protected property FileIo as FileIO no-undo 
        get():
            if not valid-object(FileIO) then
                FileIO =  new FileIO().
            return FileIO.    
        end.
        set.
      
    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    @Before.
    method public void Before   (  ):  
       deleteTempFiles().
       RestClient = new RestClient(UriSchemeEnum:http,"localhost",8080,"/main/web/api").
    end method.
 
    method public void deleteTempFiles():  
        file-info:file-name = "Temp". 
        current-window:width = 300.
        if file-info:full-pathname <> ? then
        do:
            fileio:getFiles(file-info:full-pathname, output table fileData).  
            for each fileData with width 300:
               if filedata.fileType = "text/json" and fullName matches "*-POST-*" then
                   os-delete value(filedata.fullPath) .
                 
            end.    
        end.
    end method.
    
    @Test.
    method public void TestPostCustomers():
       executePost("customers").
    end method. 
    
    method protected void executePost(pcResource as char):
       define variable oJson as JsonObject  no-undo. 
       define variable oResponse       as IHttpResponse no-undo.
       define variable cFile           as character no-undo.
       file-info:file-name = substitute ("data/post-&1.json",pcResource). 
       if file-info:full-pathname > "" then 
          oJson = JsonUtil:ReadJsonFile( file-info:full-pathname).
       else 
          Assert:IsTrue(false,"Post JSON exits").
       oResponse = RestClient:executePostRequest(pcResource,oJson).
       ProcessResponse("POST",pcResource,oResponse). 
    end method.    
    
    method protected void ProcessResponse(pcMethod as character,pcResource as character,oResponse as IHttpResponse):
        define variabl oJsonObject as JsonObject no-undo.
        define variable cSuffix as character no-undo.
        define variable cprefix as character no-undo. 
        
        cPrefix = substitute("&1-&2",
                             iso-date(today),
                             replace(string(time,"HH:MM"),":","")
                             ).
           
        if oResponse:StatusCode <> 200 then      
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
        else 
           Assert:IsTrue(false,"Response is JSON").
                 
        if oResponse:StatusCode <> 200 then     
            Assert:IsTrue(false,"Status is 200"). 
    end method.    
          
end class.