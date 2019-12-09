@isTest
public class TestStudentsMap {
    @TestSetup static void classStudentSetup() {
        Class__c cObj = new Class__c(Name='TestClass0',Max__c=12);
        insert cObj;
        List<Student__c> students = new List<Student__c>();
        for(Integer i=1;i<5;i++)
        {
            Student__c s = new Student__c(Last_Name__c='ABC'+i,class__c=cObj.Id);
            students.add(s);
        }
        insert students;
    }
    
    @isTest static void getStudentsInClass(){
        Test.startTest();
        Map<Class__c,Set<ID>> classStudentMap =  ClassStudentsMap.getStudentsInClass();
        System.debug('classStudentMap---------------------'+classStudentMap);
        for(Class__c cObj: classStudentMap.keyset()){
            Set<ID> stringset= classStudentMap.get(cObj);
            Test.stopTest();
            System.assertEquals(4, stringset.size());
        }
    }
}