public class ClassStudentsMap {
    public static  Map<Class__c,Set<ID>> getStudentsInClass()
    {	
        Map<Class__c,Set<ID>> classStudentMap = new Map<Class__c,Set<ID>>();
        Class__c[] classObjectList = [SELECT Id,(SELECT Id FROM Students__r) FROM Class__c];
        for(Class__c classobj : classObjectList)
        {	
            Set<Id> studentIds = new Set<Id>();
            for(Student__c studentObj : classobj.Students__r) {
                studentIds.add(studentObj.Id);
            }
            classStudentMap.put(classobj,studentIds);
        }
        return classStudentMap;
    }
    
}