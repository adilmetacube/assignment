global class sendEmailToOpptyOwner implements Database.Batchable<SObject>{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('Select Id,ownerID from Opportunity where LastModifiedDate = LAST_N_DAYS:30');
    }
    
    global void execute(Database.BatchableContext BC, List<Opportunity > scope){
        for(Opportunity s : scope){
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            String body = 'Not modify to last 30 days';
            string email = s.Id;
            Messaging.SingleEmailMessage mail = new
                Messaging.SingleEmailMessage();
            mail.setToAddresses(new List<string>{email});
            mail.setSubject('Not modified in last 30 days');
            mail.setPlainTextBody(body);
            mails.add(mail);
            if(mails.size() > 0){
                Messaging.sendEmail(mails);
            }
        }
    }
    global void finish(Database.BatchableContext BC){
    }
}
