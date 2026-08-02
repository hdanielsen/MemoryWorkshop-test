 
 /*------------------------------------------------------------------------
    File        : TestClinetGetRequest
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hdaniels
    Created     : Sun Aug 02 07:25:16 EDT 2026
    Notes       : 
  ----------------------------------------------------------------------*/
     
using Progress.Lang.*.
using Pmfo.Core.Service.IClientGetRequest from propath.
using OpenEdge.Core.Collections.StringStringMap from propath.
using Pmfo.Core.Service.ClientGetRequest from propath.


block-level on error undo, throw.

class tests.TestClientGetRequest inherits TestBase:
    @TEst.
   method public void TestNew():
       define variable oClientGetRequest as IClientGetRequest no-undo.
        oClientGetRequest = new ClientGetRequest("GET", "customers/orders",new StringStringMap()).
       message extent(oClientGetRequest:Collections) oClientGetRequest:Collections[1]
       view-as alert-box.
   end method.       
end class.