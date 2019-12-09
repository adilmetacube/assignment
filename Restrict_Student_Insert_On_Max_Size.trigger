trigger StudentsTrigger on Student__c (after  insert,before update) {
    Integer studentCount=0;
    Integer studentCountUpdated=0;
    Set<Id> classIds = new Set<Id>();
    for (Student__c studentObj : Trigger.new) {
        classIds.add(studentObj.Class__c);
    }
    Map<Id,Class__c> classMap = new Map<Id,Class__c>([SELECT Id,Max__c,NumberOfStudents__c FROM Class__c  WHERE Id In :classIds]);
    Map<Id,Integer> triggerModifyMap=new Map<Id,Integer>();
    for(student__c studentTriggerObj : trigger.new){
        Class__c classObj=classMap.get(studentTriggerObj.class__c);   
        if(classObj!=null){
            if(triggerModifyMap.get(classObj.id)==null){
                studentCount=classObj.NumberOfStudents__c.intValue();
                triggerModifyMap.put(classObj.id,studentCount);
            }
        }
        if(triggerModifyMap.get(studentTriggerObj.class__c) < classMap.get(studentTriggerObj.class__c).Max__c) {
            triggerModifyMap.put(studentTriggerObj.class__c,triggerModifyMap.get(studentTriggerObj.class__c)+1);
        }else {
            studentTriggerObj.addError('Class Max value exceeds the limit');
        }       
    }
    List<Class__c> classListToUpdate=new List<Class__c>();   
    for(Class__c classObj :[SELECT Id FROM Class__c WHERE Id in :classIds]){
        classObj.MyCount__c=triggerModifyMap.get(classObj.Id);
        classListToUpdate.add(classObj);
    }
    update classListToUpdate;
}
