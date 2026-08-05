 
 /*------------------------------------------------------------------------
    File        : TestRestClient
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hdaniels
    Notes       : 
  ----------------------------------------------------------------------*/


block-level on error undo, throw.

using OpenEdge.Core.Assert from propath.
using OpenEdge.Net.HTTP.IHttpResponse from propath.
using OpenEdge.Net.UriSchemeEnum from propath.
using Pmfo.Util.JsonUtil from propath.
using Pmfo.Util.RestClient from propath.
using Progress.Json.ObjectModel.JsonObject from propath.

class TestRestClientUpdate inherits TestRestBase:
   {Pmfo/Util/filedata.i}

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    @Before.
    method public void Before   (  ):  
       deleteTempFiles("POST").
       RestClient = new RestClient(UriSchemeEnum:http,"localhost",8080,"/main/web/api").
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
      
       ProcessResponse("POST",pcResource,oResponse,RestClient:uri). 
    end method.    
          
end class.