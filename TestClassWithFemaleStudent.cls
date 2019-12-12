@isTest
public class TestClassWithFemaleStudent {
     @isTest static void checkIfFemaleStudentExistInClass(){
        HelperClass.classStudentSetup();
        Class__c objClass = [select name from class__c where name='3rd'];
       Database.DeleteResult result = Database.delete(objClass, false);
        // Verify 
        // In this case the deletion should have been stopped by the trigger,
        // so verify that we got back an error.
        System.assertEquals('This class can not be deleted',
                             result.getErrors()[0].getMessage());
    }

}
