 
 /*------------------------------------------------------------------------
    File        : TestBase
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hdaniels
    Created     : Mon Apr 15 11:46:50 EDT 2019
    Notes       : 
  ----------------------------------------------------------------------*/

 

block-level on error undo, throw.

using Pmfo.Core.Service.BusinessEntityOperationHandler from propath.
using Pmfo.Tools.Test.TestBase from propath.

class TestBase inherits TestBase:
    define  override property OperationHandler as BusinessEntityOperationHandler no-undo
        get():
            if not valid-object(OperationHandler) then
                OperationHandler = new BusinessEntityOperationHandler().
            return OperationHandler.    
        end.
        set.
        
  
/*    // override to return a requestbuilder that creates Core.BusinessLogic.GetDataRequest that has Metric property                                                          */
/*    method protected override Pmfo.Core.BusinessLogic.RequestBuilder.QueryRequestBuilder CreateQueryRequestBuilder():                                                       */
/*        return new Pmfo.Core.BusinessLogic.RequestBuilder.QueryRequestBuilder().                                                                                            */
/*    end method.                                                                                                                                                             */
/*                                                                                                                                                                            */
/*    method protected override IClientGetRequest CreateClientGetRequest( input pcMethod as character, input pcServiceUri as character, input pUriQuery as IStringStringMap ):*/
/*        return new ClientGetRequest(input pcMethod, input pcServiceUri, input pUriQuery).                                                                                   */
/*    end method.                                                                                                                                                             */
/*                                                                                                                                                                            */
/*                                                                                                                                                                            */
end class.