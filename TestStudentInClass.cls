@isTest
public class TestStudentInClass {
   @TestSetup
   static void classStudentSetup() {
     
       Class__c c = new Class__c(Name='3rd',Max__c=12);
       insert c;
       List<Student__c> students = new List<Student__c>();
       for(Integer i=1;i<5;i++)
       {
           Student__c s = new Student__c(Last_Name__c='ABC'+i,class__c=c.id);
           students.add(s);
       }
       insert students;
   }

   
   
   @isTest static void getStudentsList()
   {
       Class__c c = [select name from class__c where name='3rd'];
       Test.startTest();
       List<student__c> students =  StudentsInClass.getStudentsList(c.Id);
       System.debug('students'+students);
       Test.stopTest();
           System.assertEquals(4, students.size());
   }
}