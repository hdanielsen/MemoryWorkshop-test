 
 /*------------------------------------------------------------------------
    File        : TestGenerator
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hdaniels
    Created     : Sun Aug 02 09:35:08 EDT 2026
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.*.
using Pmfo.Core.Common.DataService from propath.
using OpenEdge.DataAdmin.IDataAdminService from propath.
using OpenEdge.DataAdmin.ITableSet from propath.
using OpenEdge.DataAdmin.ITable from propath.
using OpenEdge.DataAdmin.Lang.Collections.IIterator from propath.
using Pmfo.Core.Common.NameService from propath.
using OpenEdge.DataAdmin.DataAdminService from propath.

block-level on error undo, throw.

class TestGenerator inherits DataService : 
    method public void GenerateGet():
        define variable oService     as IDataAdminService  no-undo.
        define variable oTables      as ITableSet  no-undo.
        define variable oTable       as ITable   no-undo.
        define variable oIterator    as IIterator   no-undo.
        define variable oNameService as NameService  no-undo.
        define variable cFile as character no-undo.
        define variable cPath  as character no-undo.
        define variable cClassname as character no-undo.
        define variable cResurcename as character no-undo.
        
        file-info:file-name = "tests".
        cPath = file-info:full-pathname.
        oService = new DataAdminService(?).
        oTables = oService:GetTables().
        oIterator = oTables:Iterator(). 
        oNameService = new NameService().
        oNameService:Initialize().
       
        do while oIterator:HasNext( ) with down:
           oTable = cast(oIterator:Next(),ITable).
           cClassname = oNameService:ClassName(oTable:name).
           cResurcename = oNameService:EntityName( oTable:name).
           output to value(substitute("&1/TestGet&2.cls",cPath,cClassname)).
           put unformatted "block-level on error undo, throw." skip(1).
           put unformatted substitute("class TestGet&1 inherits TestGet:",cClassname) skip(1).
           put unformatted substitute("constructor public TestGet&1( ):",cClassname) at 5 skip.
           put unformatted substitute("super(~"&1~").",cResurcename) at 9 skip.
           put unformatted "end constructor." at 5 skip(1).
           
           put unformatted "@Test." at 5 skip. 
           put unformatted "method public void TestGet(  ):" at 5 skip. 
           put unformatted "TestGetData()." at 9 skip. 
           put unformatted "end method." at 5 skip. 
           put unformatted "end class." skip.
        end.
    end method.
    
    method public void GenerateUpdate():
        define variable oService     as IDataAdminService  no-undo.
        define variable oTables      as ITableSet  no-undo.
        define variable oTable       as ITable   no-undo.
        define variable oIterator    as IIterator   no-undo.
        define variable oNameService as NameService  no-undo.
        define variable cFile as character no-undo.
        define variable cPath  as character no-undo.
        define variable cClassname as character no-undo.
        define variable cResurcename as character no-undo.
        
        file-info:file-name = "tests".
        cPath = file-info:full-pathname.
        oService = new DataAdminService(?).
        oTables = oService:GetTables().
        oIterator = oTables:Iterator(). 
        oNameService = new NameService().
        oNameService:Initialize().
       
        do while oIterator:HasNext( ) with down:
           oTable = cast(oIterator:Next(),ITable).
           cClassname = oNameService:ClassName(oTable:name).
           cResurcename = oNameService:EntityName( oTable:name).
           output to value(substitute("&1/TestUpdate&2.cls",cPath,cClassname)).
           put unformatted "block-level on error undo, throw." skip(1).
           put unformatted "using Progress.Json.ObjectModel.JsonObject from propath." skip.
           put unformatted "using OpenEdge.Core.Assert from propath." skip.
           put unformatted substitute("class TestUpdate&1 inherits TestUpdate:",cClassname) skip(1).
           put unformatted substitute("define variable JsonPosted as JsonObject no-undo.",cClassname) at 5 skip(1).
           put unformatted substitute("constructor public TestUpdate&1( ):",cClassname) at 5 skip.
           put unformatted substitute("super(~"&1~").",cResurcename) at 9 skip.
           put unformatted "end constructor." at 5 skip(1).
           
           put unformatted "@Test." at 5 skip.            
           put unformatted "method public void TestPost(  ):" at 5 skip. 
           put unformatted "JsonPosted = PostData()." at 9 skip. 
           put unformatted "end method." at 5 skip(1). 
           
           put unformatted "@Test." at 5 skip.            
           put unformatted "method public void TestDelete(  ):" at 5 skip. 
           put unformatted "if valid-object(JsonPosted) then" at 9 skip. 
           put unformatted "DeleteData(JsonPosted)." at 13 skip. 
           put unformatted "else" at 9 skip. 
           put unformatted "Assert:isTrue(false,~"Valid Json Object to Delete~")." at 13 skip. 
           put unformatted "end method." at 5 skip(1).
           
           put unformatted "end class." skip.
        end.
    end method.
    
        
    method public override void Destroy(  ).
    end method.

    method public override void Initialize(  ).
    end method.
    
    method protected character GetTemplate(pcResource as character) :
        define variable cTemplate as character no-undo
        init 
"
block-level on error undo, throw.

class TestOrder inherits TestGet:
    constructor public TestOrder (  ):  
        super (~"&1~"). 
    end constructor. 
    
    /*------------------------------------------------------------------------------
     Purpose:   Test Get All data
     Notes:
    ------------------------------------------------------------------------------*/
    @Test.
    method public void TestGet(  ):
        TestGetData().
    end method.

end class.    
".
    
       return substitute (cTemplate,pcResource). 
    end method.    
end class.