public class Contacts  extends fflib_SObjectDomain  {
    
    public Contacts(List<Contact> sObjectList)
    {
        super(sObjectList);
    }
    
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<sObject> sObjectList) {
            return new Contacts(sObjectList);
        }
    }
    
    public override void handleAfterInsert() {
        // Validate Opportunities
        for(Contact con : (List<Contact>) Records) {
            if(con.Subject__c!=null){
                if(con.Subject__c.containsIgnoreCase('Hindi') || con.Subject__c.containsIgnoreCase('--None--')){
                    con.addError('Teacher with subject as Hindi not allowed');
                }
            }
        }
    }
    public static void handleAfterUpdate(Map<Id,SObject> Records) {  
        for (Id contactId : Records.keySet()) {
            Contact con = (Contact)Records.get(contactId);
            if(con.Subject__c!=null){
                if(con.Subject__c.containsIgnoreCase('Hindi') || con.Subject__c.containsIgnoreCase('--None--')){
                    con.addError('Teacher with subject as Hindi not allowed');
                }
            }  
        }
    }
}
