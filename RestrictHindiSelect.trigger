trigger TeachersTrigger on Contact (After insert,After update) { 
    for(Contact con :Trigger.new){
        if(con.Subject__c!=null){
            if(con.Subject__c.containsIgnoreCase('Hindi') || con.Subject__c.containsIgnoreCase('--None--')){
                con.addError('Teacher with subject as Hindi not allowed');
            }
        }
    }
}
