public interface IPurchaseOrdersSelector {
    List<Schema.SObjectField> getSObjectFieldList();
    Schema.SObjectType getSObjectType();
    List<PurchaseOrder__c> selectById(Set<ID> idSet);
    List<PurchaseOrder__c> getPurchaseOrders(Integer numberOfRecords, Integer counter);
}
