trigger TeachersTrigger on Contact (After insert,After update) { 
    for(Contact con :Trigger.new)
        if(con.Subject__c.contains('Hindi')){
            con.addError('Teacher with subject as Hindi not allowed');
        }
}
