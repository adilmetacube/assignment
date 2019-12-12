@isTest
public class HelperClass {
    public static void classStudentSetup() {
        Class__c c = new Class__c(Name='3rd',Max__c=12);
        insert c;
        List<Student__c> students = new List<Student__c>();
        for(Integer i=1;i<5;i++)
        {
            Student__c s = new Student__c(Last_Name__c='ABC'+i,class__c=c.id,Sex__c='Female');
            students.add(s);
        }
        insert students;
    }
    
}