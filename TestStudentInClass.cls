@isTest
public class TestStudentInClass {
    @isTest static void getStudentsList()
    {
        HelperClass.classStudentSetup();
        Class__c c = [select name from class__c where name='3rd'];
        List<student__c> students =  StudentsInClass.getStudentsList(c.Id);
        System.assertEquals(4, students.size());
    }
}
