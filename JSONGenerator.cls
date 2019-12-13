public with sharing class JSONGenerator {
  
    public String jsonStr {get;private set;}
    
    // constructor outer class
    public JSONGenerator(){
        jsonStr = prepareJSON();
    }
    
    // inner class
    class BillingStatement {
        Long billNumber;
        Datetime statementDate;
        Decimal totalPrice;
		// constructor of inner class
        public BillingStatement(Long billNumber, Datetime statementDate, Decimal totalPrice) {
            this.billNumber = billNumber;
            this.statementDate = statementDate;
            this.totalPrice = totalPrice;
        }
	}
    
    private String prepareJSON() {
        Datetime dt = Datetime.now(); 
        // Create a few bills.
        BillingStatement bill1 = new BillingStatement(1,Datetime.now(),1000);
        BillingStatement bill2 = new BillingStatement(2,Datetime.now(),500);
        BillingStatement bill3 = new BillingStatement(2,Datetime.now(),250);
        // Add the bills to a list.
        List<BillingStatement> bills = new List<BillingStatement>();
        bills.add(bill1);
        bills.add(bill2);
        bills.add(bill3);
        // Serialize the list of BillingStatement objects.
        jsonStr = JSON.serialize(bills);
		// return the JSON string
		return jsonStr;
       
    }
}