trigger ClassTrigger on Class__c (before delete ) {
    fflib_SObjectDomain.triggerHandler(Classes.class);
}
