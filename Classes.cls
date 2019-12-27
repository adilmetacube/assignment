public class Classes  extends fflib_SObjectDomain  {
    
    public Classes(List<Class__c> sObjectList)
    {
        super(sObjectList);
    }
    
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<sObject> sObjectList) {
            return new Classes(sObjectList);
        }
    }
    
    public override void handleBeforeDelete() {
        List<Class__c> classList=[SELECT Name,(SELECT First_Name__c,Date_of_Birth__c,Sex__c FROM Students__r WHERE Sex__c='female') FROM Class__c WHERE Id  IN :Records ];
        for(Class__c classObject : classList){    
            if(classObject.Students__r.size() > 1){
                Trigger.oldMap.get(classObject.Id).adderror('This class can not be deleted');
            }
        }
    }
}
