public class AccountInsUpdExc {
    
    public void doAccInsUpdExc(){
        Account[] ar=new List<Account>();
        for(Integer i=0;i<3;i++){
            Account a= new Account(Name='ac'+i,BillingCity='Sanfrancisco');
            ar.add(a);
        }
        try{
            insert ar;
            
            Account updated;
            updated=[Select name,BillingCity from Account where name='ac1' limit 1];
            updated.BillingCity='New York';
            update updated;
            
            
        }catch(DmlException d){
            d.getMessage();
        }
        
        Account chkUpdate=[select BillingCity from Account where name='ac1' limit 1];
        System.assertEquals('New York', chkUpdate.BillingCity);
        
    }

}