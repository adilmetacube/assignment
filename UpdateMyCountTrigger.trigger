trigger UpdateMyCountTrigger on Student__c (after insert , after update) {
    Integer studentCountInClass;
    AggregateResult[] aggregatedRecords=[select  count(First_Name__c),Class__r.name,Class__r.id from Student__c
                                          where class__r.id =:Trigger.new[0].Class__c
                                          group by Class__r.name ,Class__r.id];

    for (AggregateResult ar : aggregatedRecords)  {
        studentCountInClass= (Integer)ar.get('expr0');
}
     for(Class__c classObject:[select Max__c,(select id from Students__r) from Class__c where id=:Trigger.new[0].Class__c]){
        classObject.MyCount__c=studentCountInClass;
          update classObject;
      }
   }