public class InsertContactIds {
    public static void InsertContactIdsInAccount(ID id ){
        Contact c=[select id,name,account.id from Contact where id=:id];
        System.debug('contact object '+c);
        Account a=[select id,ContactIDs__c,(select name,id from contacts)  from Account where id=:c.account.id ];
        System.debug('a object---------:'+a.contacts.size());
        String contactIDs='';
       		for(Contact con:a.contacts){
                if(a.ContactIDs__c==NULL && string.isEmpty(contactIDs)){
                   		contactIDs=contactIDs+con.id+',';
                }else{
                	contactIDs=contactIDs+con.id;
                }
                System.debug('contactIDs :'+contactIDs);
            }
        a.ContactIDs__c=contactIDs;
        update a;
        }
    }