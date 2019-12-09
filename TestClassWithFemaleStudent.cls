@isTest
public class TestClassWithFemaleStudent {
     @isTest static void checkIfFemaleStudentExistInClass(){
        Class__c objectClass=new Class__c(Name='7th');
         insert objectClass;
         Student__c objectStudentFirst=new Student__c(First_Name__c='Nisha',Last_Name__c='kumari',Sex__c='Female',Class__c=objectClass.Id);
         insert objectStudentFirst;
         Student__c objectStudentSecond=new Student__c(First_Name__c='Puja',Last_Name__c='kumari',Sex__c='Female',Class__c=objectClass.Id);
			insert objectStudentSecond;        
         Test.startTest();
       Database.DeleteResult result = Database.delete(objectClass, false);
        Test.stopTest();
        // Verify 
        // In this case the deletion should have been stopped by the trigger,
        // so verify that we got back an error.
        System.assertEquals('This class can not be deleted',
                             result.getErrors()[0].getMessage());
    }

}