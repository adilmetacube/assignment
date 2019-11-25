public class AccountUpdAndCheck {
    
    public void doCheckInsertAndUpdate(){
      Account a=[select name,industry from Account where name='Aman' limit 1];
        System.debug('name is :'+a.Name);
        System.debug('industry is :'+a.Industry);
        
        a.Industry='TECHNOLOGY';
        update a;
        
        Account up=[select name,industry from Account where name='Aman' limit 1];
        System.debug('updated industry :'+up.Industry);
        System.assertEquals('Technology', up.Industry);
    }

}