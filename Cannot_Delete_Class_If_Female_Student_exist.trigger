trigger ClassTrigger on Class__c (before delete , after update) {
    if(Trigger.IsDelete){
        List<Class__c> classList=[SELECT Name,(SELECT First_Name__c,Date_of_Birth__c,Sex__c FROM Students__r WHERE Sex__c='female') FROM Class__c WHERE Id  IN :Trigger.old ];
        for(Class__c classObject : classList){    
            if(classObject.Students__r.size() > 1){
                Trigger.oldMap.get(classObject.Id).adderror('This class can not be deleted');
            }
        }
    }
    if(Trigger.isUpdate) {
        List<Id> classIds = new List<Id>();
        for (Class__c objClass:Trigger.New) {
            if (objClass.Custom_Status__c != Trigger.OldMap.Get(objClass.Id).Custom_Status__c && (objClass.Custom_Status__c == 'Reset')) {
                classIds.add(objClass.Id);
            }
        }
        List<Student__c> listOfStudents=[SELECT Id from Student__c WHERE class__r.Id IN :classIds];
        if(listOfStudents!=Null && listOfStudents.size() > 0){
            delete listOfStudents;
        }
    }
}
