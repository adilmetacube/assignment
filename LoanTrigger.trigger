trigger LoanTrigger on Loan__c (before insert, before update) {
    Set<Id> cityMangIds = new Set<Id>();
    for(Loan__c loanObj :Trigger.new){
        cityMangIds.add(loanObj.City__c);
    }
    List<CityManager__c> cityManList=[SELECT Id,Name,Manager__c FROM CityManager__c WHERE ID IN : cityMangIds];
    for(Loan__c loanObj :Trigger.new){
        if(loanObj.Manager__c==null){
            for(CityManager__c cityManObj:cityManList){
                if(loanObj.City__c==cityManObj.Id){
                    loanObj.Manager__c=cityManObj.Manager__c;
                }
            }
        }
    }
    
    if (Trigger.IsBefore && Trigger.isUpdate) {
        List<Loan__c> loans=new List<Loan__c>();
        for (Loan__c loan:Trigger.New) {
            if (loan.Status__c != Trigger.OldMap.Get(loan.Id).Status__c) {
                loans.add(loan);
            }
        }
        EmailSender.email_send(loans);
    }
    
}
