public class ShoppingController {
    public List<PurchaseOrder__c> orderList {get;set;}
    public String numberOfRecords='10';
    private integer counter=0;  //keeps track of the offset
    private integer counter_product=0;
    private integer list_size=2; //sets the page size or number of rows
    private integer list_size_product=2;
    public integer total_size; //used to show user the total size of the list
    public integer total_size_product;
    public boolean showProductStatus {get;set;}
    public boolean showCartDataStatus {get;set;}
    public boolean showInvoiceDataStatus {get;set;}
    public List<wrapProduct> wrapProductList {get; set;}
    public List<Product__c> selectedProduct {get;set;}
    public String productName {get; set;}
    public String selectedRowId {get; set;}
    List<PurchaseOrderLineItems__c> orderLineList {get; set;}
    Map<Product__c,Integer> productAvailable=new  Map<Product__c,Integer>();
    public String quantityOnChange {get; set;}
    
    
    public ShoppingController(){
        orderList = new List<PurchaseOrder__c>();
        total_size = [select count() from PurchaseOrder__c];
        total_size_product=[select count() from Product__c];
    }
    
    public class wrapProduct {
        public Product__c product {get; set;}
        public Boolean selected {get; set;}
        public wrapProduct(Product__c p) {
            product = p;
            selected = false;
        }
    }
    
    public List<wrapProduct> getProducts(){
        if(String.isBlank(numberOfRecords))
            numberOfRecords='10';
        if(wrapProductList==null){
            System.debug('getProducts in if wrapProductList==null');
            wrapProductList=new List<wrapProduct>();
            string searchquery='SELECT name,ProductCode__c,Description__c,'
                + ' Product_Price__c, Quantity_Available__c FROM Product__c ' 
                + ' Limit '+numberOfRecords+ ' offset '+counter_product;
            System.debug('searchquery--:'+searchquery);
            List<Product__c> productList= Database.query(searchquery);
            for(Product__c product:productList){
                wrapProductList.add(new wrapProduct(product));
                productAvailable.put(product,product.Quantity_Available__c.intValue());
            }
        }
        return wrapProductList ;
    }
    
    public void searchProducts(){
        System.debug('IN search searchProducts');
        String searchquery='SELECT name,ProductCode__c,Description__c,Product_Price__c, Quantity_Available__c FROM Product__c ' ;
        if(String.isBlank(numberOfRecords))
            numberOfRecords='10';
        wrapProductList=new List<wrapProduct>();
        if(productName!=null && String.IsNotBlank(productName)){
            searchquery=searchquery +' WHERE name LIKE  \''+productName+'%\'';
        }
        searchquery=searchquery+'Limit '+numberOfRecords+ ' offset '+counter_product;
        System.debug('searchquery--:'+searchquery);
        List<Product__c> productList= Database.query(searchquery);
        for(Product__c product:productList){
            wrapProductList.add(new wrapProduct(product));
        }
    }
    public void addToCart(){
        selectedProduct = new List<Product__c>();
        Boolean selectStatus=false;
        orderLineList= new List<PurchaseOrderLineItems__c>();
        List<Product__c> productList=new List<Product__c>();
        for(wrapProduct wrapProductObj : wrapProductList) {
            if(wrapProductObj.selected == true) {
                selectStatus=true;
                selectedProduct.add(wrapProductObj.product);
                PurchaseOrderLineItems__c orderLineItem=new  PurchaseOrderLineItems__c(name=wrapProductObj.product.name,
                                                                                       Product_Code__c=wrapProductObj.product.ProductCode__c,
                                                                                       Product__c=wrapProductObj.product.Id,
                                                                                       Product_Price__c=wrapProductObj.product.Product_Price__c,
                                                                                       Quantity__c=1);
                orderLineList.add(orderLineItem); 
                wrapProductObj.product.Quantity_Available__c= wrapProductObj.product.Quantity_Available__c-1;
                showCartDataStatus=true;
            }
        }
        if(!selectStatus){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select any product.'));
        }
        System.debug('orderLineList--'+orderLineList);
        System.debug('product in cart'+selectedProduct);
        System.Debug('Products  --->'+ getProducts());        
    }
    
    public List<PurchaseOrderLineItems__c>  getOrderLineItems(){
        return orderLineList;
    }
    
    public void placeOrder(){
        PurchaseOrder__c pOrder=new PurchaseOrder__c(name='New Order Test',Order_Status__c='Pending');
        insert pOrder;
        for(PurchaseOrderLineItems__c pOrderline:orderLineList){
            pOrderline.PurchaseOrder__c=pOrder.Id;      
        }
        System.Debug('orderLineList---------->>>>>'+orderLineList);
        showProductStatus=false;
        showCartDataStatus=false;
        showInvoiceDataStatus=false;
        insert orderLineList;
    }
    
    
    public List<PurchaseOrder__c> getPurchaseOrder(){
        if(String.isBlank(numberOfRecords))
            numberOfRecords='2';
        string searchquery='SELECT Id, Order_Price__c, Order_Status__c FROM PurchaseOrder__c '
            + ' WHERE OwnerID= \''+UserInfo.getUserId()+'\''
            + ' Limit '+numberOfRecords+ ' offset '+counter;
        System.debug('searchquery--:'+searchquery);
        return Database.query(searchquery);
    }
    public void deleteProduct(){
        for (Integer i = 0; i < orderLineList.size(); i++) {
            PurchaseOrderLineItems__c pOrderLineItem = orderLineList[i];
            // wrapProduct wrapProduct=wrapProductList[i];
            if (pOrderLineItem.Product__c == selectedRowId) {
                // Product__c productToUpdate=new Product__c(Id=pOrderLineItem.Product__c,Quantity_Available__c=pOrderLineItem.Quantity_Available__c+1);
                System.debug('pOrderLineItem--------'+pOrderLineItem);
                System.debug('selectedRowId--------'+selectedRowId);
                System.debug('wrapProductList--------'+wrapProductList);
                orderLineList.remove(i);
                updateProductList(selectedRowId,pOrderLineItem.Quantity__c.intValue());
                break;
            }
        }
    }    
    
    public void updateProductList(String productId,Integer quantity){
        for(wrapProduct wProduct:wrapProductList){
            if(wProduct.product.Id==productId ){
                wProduct.product.Quantity_Available__c=wProduct.product.Quantity_Available__c+quantity;
                wProduct.selected=false;
            } 
        }
    }
    
    public void changeProductQuantity(){
        System.debug('orderLineList------>>>'+getorderLineItems());
        System.debug('wrapProductList------>>>'+wrapProductList);
        for(PurchaseOrderLineItems__c orderLineItems:getorderLineItems()){
            for(wrapProduct wProduct:wrapProductList){
                if(orderLineItems.Product__c==wProduct.product.Id){  
                    quantityValidate(orderLineItems.Quantity__c.intValue(),String.valueOf(wProduct.product.Id));
                }
            }
        }    
    }
    public void quantityValidate(Integer quantity,String productId){
        if(quantity>=1){
            Integer quantityNo=Integer.valueOf(quantity);
            wrapProduct wproduct=getProductOnId(productId);
            System.debug('productAvailable.get(wProduct.product)----->>>>'+productAvailable.get(wProduct.product));
            if((quantityNo<=productAvailable.get(wProduct.product))){
                wProduct.product.Quantity_Available__c =productAvailable.get(wProduct.product)-quantity;
            }else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Quantity can never exceeds product available quantity .'));  
            }}
        else{
            System.debug('apex message else');
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Quantity can never be zero,blank or negative.'));
        }
    }
    
    public wrapProduct getProductOnId(String productId){
        wrapProduct prod=null;
        for(wrapProduct wProduct:wrapProductList){
            if(wProduct.product.Id==productId){
                return wProduct;
            }
        } 
        return prod;
    }
    
    public void showProducts(){
        System.debug('showProducts');
        showProductStatus=true;
    }
    
    public void showInvoice(){
        showInvoiceDataStatus=true;
        
    }
    
    public Decimal getGrossTotal(){
        Decimal grossTotal = 0;
        for(PurchaseOrderLineItems__c orderLineItems : getorderLineItems()) {
            grossTotal += (orderLineItems.Quantity__c.intValue() * orderLineItems.Product_Price__c);
        }
        return grossTotal;
    }
    
    public PageReference Beginning() { //user clicked beginning
        counter = 0;
        return null;
    }
    public PageReference BeginningProduct() { //user clicked beginning
        counter_product = 0;
        return null;
    }
    
    public PageReference Previous() { //user clicked previous button
        counter -= list_size;
        getPurchaseOrder();
        return null;
    }
    public PageReference previousProduct() { //user clicked previous button
        counter_product -= list_size_product;
        searchProducts();
        return null;
    }
    
    public PageReference Next() { //user clicked next button
        counter += list_size;
        getPurchaseOrder();
        return null;
    }
    public PageReference nextProduct() { //user clicked next button
        counter_product += list_size_product;
        searchProducts();
        return null;
    }
    
    public PageReference End() { //user clicked end
        counter = total_size - math.mod(total_size, list_size);
        getPurchaseOrder();
        return null;
    }
    public PageReference endProduct() { //user clicked end
        counter_product = total_size_product - math.mod(total_size_product, list_size_product);
        searchProducts();
        return null;
    }
    
    public Boolean getDisablePrevious() { 
        //this will disable the previous and beginning buttons
        if (counter>0) return false; else return true;
    }
    public Boolean getDisablePreviousForProduct() { 
        //this will disable the previous and beginning buttons
        if (counter_product>0) return false; else return true;
    }
    
    public Boolean getDisableNext() { //this will disable the next and end buttons
        if (counter + list_size < total_size) return false; else return true;
    }
    public Boolean getDisableNextForProduct() { //this will disable the next and end buttons
        if (counter_product + list_size_product < total_size_product) return false; else return true;
    }
    
    public Integer getTotal_size() {
        return total_size;
    }
    
    public Integer getTotal_size_Product() {
        return total_size_product;
    }
    public Integer getPageNumber() {
        return counter/list_size + 1;
    }
    public Integer getPageNumberProduct() {
        return counter_product/list_size_product + 1;
    }
    
    public Integer getTotalPages() {
        if (math.mod(total_size, list_size) > 0) {
            return total_size/list_size + 1;
        } else {
            return (total_size/list_size);
        }
    }
    public Integer getTotalPagesProduct() {
        if (math.mod(total_size_product, list_size_product) > 0) {
            return total_size_product/list_size_product + 1;
        } else {
            return (list_size_product/list_size_product);
        }
    }
}