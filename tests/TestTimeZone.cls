 
 /*------------------------------------------------------------------------
    File        : TestTimeZone
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hdaniels
    Created     : Mon Sep 14 10:28:41 EDT 2026
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
using Pmfo.Tools.Test.TestBase.
using Pmfo.Util.TimeZoneUtil from propath.

block-level on error undo, throw.

class TestTimeZone inherits TestBase:
    
    @Test.
    method public void TestAssignMemPointer():
         
        TimeZoneUtil:TimeZoneName = "Eastern Standard Time".  
         
        message "here"  
        
        view-as alert-box.
        
   
        
        catch e as Progress.Lang.Error :
            ShowErrors = true.
               message e:GetMessage(1)
               view-as alert-box. 
        end catch.
        
    end.      
    
    @Test.
    method public void TestGEtMemPointer():
         
     //   TimeZoneUtil:TimeZoneName = "Eastern Standard Time".  
         
        message TimeZoneUtil:TimeZoneName
        view-as alert-box.
        
        catch e as Progress.Lang.Error :
            ShowErrors = true.
               message e:GetMessage(1)
               view-as alert-box. 
        end catch.
        
    end.      
    
      
end class.