@isTest
public class TestForCustomStatus {
    @isTest static void testCustomStatus(){
        Class__c objectClass1=new Class__c(Name='7th',Max__c=3);
        insert objectClass1;
        Student__c objectStudentFirst=new Student__c(First_Name__c='Nisha',Last_Name__c='kumari',Sex__c='Female',Class__c=objectClass1.Id);
        insert objectStudentFirst;
        Student__c objectStudentSecond=new Student__c(First_Name__c='Puja',Last_Name__c='kumari',Sex__c='Female',Class__c=objectClass1.Id);
        insert objectStudentSecond;        
        
        objectClass1.Custom_Status__c='Reset';
        update objectClass1;
        Class__c classObj=[select Id from Class__c where id =:objectClass1.Id ];
        System.assertEquals(0,classObj.Students__r.size());
        
    }
}