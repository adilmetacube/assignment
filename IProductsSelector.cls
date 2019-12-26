public interface IProductsSelector {
     List<Schema.SObjectField> getSObjectFieldList();
     Schema.SObjectType getSObjectType();
     List<Product__c> selectById(Set<ID> idSet);
     List<Product__c> getProducts(Integer numberOfRecords, Integer counter_product,String productName);
}
