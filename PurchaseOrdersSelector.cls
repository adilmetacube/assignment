public class PurchaseOrdersSelector extends fflib_SObjectSelector implements IPurchaseOrdersSelector {
    private static PurchaseOrdersSelector instance = null;
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            PurchaseOrder__c.Order_Price__c,
                PurchaseOrder__c.Id,
                PurchaseOrder__c.Order_Status__c};
                    }
    public Schema.SObjectType getSObjectType() {
        return PurchaseOrder__c.sObjectType;
    }
    public List<PurchaseOrder__c> selectById(Set<ID> idSet) {
        return (List<PurchaseOrder__c>) selectSObjectsById(idSet);
    }
    public static PurchaseOrdersSelector getInstance(){
        if(instance == null) instance = new PurchaseOrdersSelector();
        return instance;
    }
    
    public List<PurchaseOrder__c> getPurchaseOrders(Integer numberOfRecords, Integer counter){ 
        List<PurchaseOrder__c> poList=  (List<PurchaseOrder__c>) Database.query(
                newQueryFactory().setLimit(numberOfRecords).setOffset(counter).toSOQL()
            );
        return poList;
    }
}
