trigger RestrictHindiSelect on Contact (before insert,before update) { 
    for(Contact con :Trigger.new)
        if(con.Subject__c=='Hindi')
            con.addError('You can choose other subject');

}