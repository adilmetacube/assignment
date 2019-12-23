public class createContact {
 
    @AuraEnabled
    public static Contact createContact(Contact contact) {
        insert contact;
        return contact;
    }
}
