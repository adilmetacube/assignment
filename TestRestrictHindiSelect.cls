@isTest
public class TestRestrictHindiSelect {
    @isTest static void restrictTeacherToSelectHindi(){
        List<Contact> contactList= new List<Contact>();
        Contact objCont1=new Contact(LastName='a',Subject__c='Hindi');
        Contact objCont2=new Contact(LastName='pqr',Subject__c='Hindi;English');
        Contact objCont3=new Contact(LastName='xyz',Subject__c='English');
        contactList.add(objCont1);
        contactList.add(objCont2);
        contactList.add(objCont3);
        Test.startTest();
        Database.SaveResult[] result = Database.insert(contactList,false);
        System.debug('result------'+result);
        for (Database.SaveResult sr : result) {
            // Operation failed, so get all errors                
            for(Database.Error err : sr.getErrors()) {          
                System.assertEquals('You can choose other subject',err.getMessage());
            }
        }
        Test.stopTest();
    }
}