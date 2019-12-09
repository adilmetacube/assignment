trigger TeachersTrigger on Contact (After insert,After update) { 
    for(Contact con :Trigger.new)
        if(con.Subject__c=='Hindi;English' || con.Subject__c=='Hindi')
            con.addError('You can choose other subject');

}
