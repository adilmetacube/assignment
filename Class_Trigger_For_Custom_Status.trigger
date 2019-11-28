trigger Class_Trigger_For_Custom_Status on Class__c (BEFORE UPDATE) {
	if (Trigger.IsBefore && Trigger.isUpdate) {
		for (Class__c objClass:Trigger.New) {
			if (objClass.Custom_Status__c != Trigger.OldMap.Get(objClass.Id).Custom_Status__c && (objClass.Custom_Status__c == 'Reset')) {
				 list<Student__c> listOfStudents=[select First_Name__c from Student__c where class__r.id in :Trigger.New];
  				  system.debug('listOfStudents'+listOfStudents);
    				delete listOfStudents;
			}
		}
	}
}