@isTest
public class TestStudentsMap {
    @isTest static void testStudentsInClass(){
        HelperClass.classStudentSetup();
        Class__c classobj=[SELECT Id FROM Class__c WHERE Name='3rd'];
        Map<Class__c,Set<ID>> classStudentMap =  ClassStudentsMap.getStudentsInClass();
        System.assertEquals(4, classStudentMap.get(classobj).size());
    }
}
