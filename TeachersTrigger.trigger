trigger TeachersTrigger on Contact (After insert,After update) { 
    fflib_SObjectDomain.triggerHandler(Contacts.class);
    if (Trigger.isAfter && Trigger.isUpdate){
       Contacts.handleAfterUpdate(trigger.newmap);
    }
}
