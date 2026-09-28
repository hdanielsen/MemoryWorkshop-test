 
 /*------------------------------------------------------------------------
    File        : TestCreateTable
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hdaniels
    Created     : Fri Sep 25 16:50:16 EDT 2026
    Notes       : 
  ----------------------------------------------------------------------*/


block-level on error undo, throw.

class TestCreateTable:
    {schema/customer.i}
    
    
    @Test.
    method public void CreateTable():
        define variable hTable as handle no-undo.
        define variable hBuffer as handle no-undo.
        
        create temp-table hTable.
        hTable:create-like(buffer ttCustomer:handle).
        
        hTable:temp-table-prepare("ttCustomer",true).
      //  hTable:before-table:name = "biCustomer".
        
        CreateData(input table-handle hTable).
        return.
        
        catch e as Progress.Lang.Error :
              message e:GetMessage(1)
              view-as alert-box.  
        end catch.
    end method.      
    
    method protected void CreateDAta(input table ttCustomer):
        create ttCustomer.
        ttcustomer.name = "anders".
        
        display ttCustomer.
        
        message temp-table ttCustomer:before-table:name  
        view-as alert-box.
          
    end method.  
    
    
      
      
end class.