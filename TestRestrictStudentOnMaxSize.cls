@isTest
public class TestRestrictStudentOnMaxSize {
    @isTest static void checkIfStudentExceedsMaxSize(){
        Class__c objectClass1=new Class__c(Name='7th',Max__c=1);
         Class__c objectClass2=new Class__c(Name='3rd',Max__c=1);
        insert objectClass1;
        insert objectClass2;
        
        List<Student__c> studentList = new List<Student__c> {
            new Student__c(First_Name__c='Joe',Last_Name__c='Smith',Sex__c='Female',Class__c=objectClass1.Id),
                new Student__c(First_Name__c='Kathy',Last_Name__c='Smith',Sex__c='Female',Class__c=objectClass1.Id),
                new Student__c(First_Name__c='Caroline',Last_Name__c='Roth',Sex__c='Female',Class__c=objectClass2.Id),
                new Student__c(First_Name__c='Kim',Last_Name__c='Shain',Sex__c='Female',Class__c=objectClass2.Id)};
                    
                    
                    Test.startTest();
        Database.SaveResult[] result = Database.insert(studentList,false);
        for (Database.SaveResult sr : result) {
            // Operation failed, so get all errors                
            for(Database.Error err : sr.getErrors()) {          
                System.assertEquals('Class Max value exceeds the limit',err.getMessage());
            }
        }
    }
}