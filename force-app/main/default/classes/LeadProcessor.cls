global class LeadProcessor implements 
    Database.Batchable<sObject>, Database.Stateful {
    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT name from lead' 
        );
    }
    global void execute(Database.BatchableContext bc, List<Lead> leads){
        for (Lead lead : leads) {
            	lead.LeadSource='Dreamforce';
                recordsProcessed = recordsProcessed + 1;
            }
        update leads;
    }    
    global void finish(Database.BatchableContext bc){
        Id job= bc.getJobId();
        System.debug(job);
    }    
}