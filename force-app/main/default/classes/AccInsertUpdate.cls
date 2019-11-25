public class AccInsertUpdate {
    
    public void doAccInsUpd(){
        Account a= new Account(Name = 'Acme', BillingCity = 'San Francisco');
        insert a;
        
       // sObject s=[select id,name from Account where name='Acme' limit 1];
       // ID id=s.ID;
       // Account upd=(Account)s;
        //upd.name='Acme 3';
        //update upd;
        
    }

}