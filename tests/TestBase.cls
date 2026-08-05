 
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

using Pmfo.Core.Service.IBusinessEntityOperationHandler from propath.
using Pmfo.Tools.Test.TestBase from propath.
using Pmfo.Core.Service.BusinessEntityOperationHandler from propath.

class TestBase inherits TestBase:
    define override property OperationHandler as IBusinessEntityOperationHandler no-undo
        get():
            if not valid-object(OperationHandler) then
                OperationHandler = new BusinessEntityOperationHandler().
            return OperationHandler.    
        end.
        set.
end class.