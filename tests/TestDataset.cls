 
 /*------------------------------------------------------------------------
    File        : TestDataset
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hdaniels
    Created     : Sat Sep 26 12:50:18 EDT 2026
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Json.ObjectModel.JsonObject from propath.
using Pmfo.Tools.Test.TestBase from propath.
using Pmfo.Util.DatasetUtil from propath.
using Business.ItemBE from propath.
using Pmfo.Core.BusinessLogic.IQueryPredicate from propath.
using Ccs.BusinessLogic.QueryOperatorEnum from propath.
using Pmfo.Core.BusinessLogic.QueryPredicate from propath.
using Pmfo.Util.Array from propath.

block-level on error undo, throw.

class TestDataset inherits TestBase :
    {schema/order.i}
    {schema/orderline.i}
    
    define dataset dsOrder for ttOrder, ttOrderLine
       data-relation order-lines for ttOrder, ttOrderLine relation-fields(orderNum,orderNum) nested foreign-key-hidden
       .
    
    {schema/item.i}

    define dataset dsItem for ttItem.
    
    @Test.
    method public void TestMulti():
       define variable oJson as JsonObject no-undo.
       define variable hDataset as handle no-undo.
       define variable hBuffer as handle no-undo. 
       oJson = LoadJson(substitute("data/post-&1.json","orders")).
         // set tracking on all buffer so the records will be marked as row-created when using read-json 
       DatasetUtil:SetTrackingChanges(dataset dsOrder:handle,true).         
       dataset dsOrder:read-json ("JsonObject",oJson).  
       ProcessData(input dataset dsOrder by-reference).  
       
       hDataset = DatasetUTil:CreateDatasetFromMultipleDatasets(Array:ToArray(dataset dsOrder:handle,dataset dsItem:handle)).
       
       hDataset:write-json("file","temp/ordersitems.json",yes).
       
    end method.         
    
    @Test.
    method public void TestAddBuffer():
       define variable oJson as JsonObject no-undo.
       define variable hDataset as handle no-undo.
       define variable hBuffer as handle no-undo. 
                                              
       create buffer hBuffer for table buffer ttitem:handle buffer-name "items".   
       hBuffer:serialize-name = "items".
       dataset dsOrder:add-buffer(hBuffer).
      // hDataset = DatasetUTil:CreateDatasetFromMultipleDatasets(Array:ToArray(dataset dsOrder:handle,dataset dsItem:handle)).
       
      // hDataset:write-json("file","temp/ordersitems.json",yes).
       
    end method.         
    
    
    
    
    method protected void ProcessData(input dataset dsOrder):
       define variable OItemBe as ItemBE no-undo.
       define variable oQueryPredicate as IQueryPredicate no-undo.
       oItemBe = cast(ServiceManager:CreateBusinessEntity("items"),ItemBe).
       
       
       for each ttOrderline:  
           oQueryPredicate = new QueryPredicate("ItemNum",QueryOperatorEnum:Eq,ttOrderLine.ItemNUm).
            // NOTE GetData(with output table does not support by-reference -    
           oItemBE:GetData(oQueryPredicate, output table ttItem append).
           find ttItem where ttitem.itemNum = ttOrderLine.ItemNUm.
        
       end. 
    end.     
    
      
end class.