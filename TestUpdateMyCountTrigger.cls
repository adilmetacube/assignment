@isTest
public class TestUpdateMyCountTrigger {
    @isTest static void checkUpdateMyCountOnStudent(){
        List<Class__c> classLists=new List<Class__c>();
         Class__c objectClass1=new Class__c(Name='7th',Max__c=1);
         Class__c objectClass2=new Class__c(Name='3rd',Max__c=1);
        classLists.add(objectClass1);
         classLists.add(objectClass2);
        insert classLists;
        
        List<Student__c> studentList = new List<Student__c> {      new Student__c(First_Name__c='Joe',Last_Name__c='Smith',Sex__c='Female',Class__c=objectClass1.Id),
                new Student__c(First_Name__c='Kathy',Last_Name__c='Smith',Sex__c='Female',Class__c=objectClass1.Id),
                new Student__c(First_Name__c='Caroline',Last_Name__c='Roth',Sex__c='Female',Class__c=objectClass2.Id),
                new Student__c(First_Name__c='Kim',Last_Name__c='Shain',Sex__c='Female',Class__c=objectClass2.Id)};
                    
                    
        Database.SaveResult[] result = Database.insert(studentList,false);
        List<Class__c> classList=[select Max__c,MyCount__c from Class__c where id In : classLists];
        for(Class__c objClass:classList){
            System.assertEquals(1,objClass.MyCount__c);
        }
        
        
    }
}
