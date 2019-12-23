public class  EmailSender{
    public static void email_send(list<Loan__c> loanList)
    {
        
        List<Messaging.SingleEmailMessage > Email_list=new List<Messaging.SingleEmailMessage >();
        for(Loan__c loan:loanList)
        {
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.toAddresses =new String[] {loan.Email__c};
                message.setSubject('Email test');
            String Body_data='';
            Body_data=loan.Status__c;
            message.sethtmlBody(Body_data);
            Email_list.add(message);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {message });
            
        }	
    }
    
    public static void emailSendOpp(list<Opportunity> oppList)
    {
        System.debug('email send'+oppList);
        EmailTemplate emailTemplate = [Select Id from EmailTemplate where name = 'Test Account Alert Email'];
        List<Messaging.SingleEmailMessage > Email_list=new List<Messaging.SingleEmailMessage >();
        for(Opportunity opp:oppList)
        {
            Opportunity oObj =[SELECT Id, Owner.Name,Owner.email ,OwnerId, Name FROM Opportunity where id=:opp.Id];
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.toAddresses =new String[] {oObj.Owner.email};
                message.setSubject('Email test');
            String Body_data='';
            Body_data=opp.StageName;
            message.sethtmlBody(Body_data);
            message.setTemplateId(emailTemplate.Id);
            Email_list.add(message);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {message });
        }	
    }
}
