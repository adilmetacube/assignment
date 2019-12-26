public class ProductsSelector extends fflib_SObjectSelector implements IProductsSelector{
    private static ProductsSelector instance = null;
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Product__c.Description__c,
                Product__c.Id,
                Product__c.Name,
                Product__c.ProductCode__c,
                Product__c.Product_Price__c , 
                Product__c.Quantity_Available__c };
                    }
    public Schema.SObjectType getSObjectType() {
        return Product__c.sObjectType;
    }
    public static ProductsSelector getInstance(){
        if(instance == null) instance = new ProductsSelector();
        return instance;
    }
    public List<Product__c> selectById(Set<ID> idSet) {
        return (List<Product__c>) selectSObjectsById(idSet);
    }
    public List<Product__c> getProducts(Integer numberOfRecords, Integer counter_product,String productName){
        List<Product__c> prodlist=null;
        if(String.isNotBlank(productName) || String.isNotEmpty(productName)){
            prodlist = (List<Product__c>) Database.query(
                newQueryFactory().  
                setCondition('name LIKE  \''+productName+'%\'').
                setLimit(numberOfRecords).setOffset(counter_product).toSOQL()
            );
        }else{
            prodlist = (List<Product__c>) Database.query(
                newQueryFactory().setLimit(numberOfRecords).setOffset(counter_product).toSOQL()
            );
        }
        return prodlist;
    }
}
