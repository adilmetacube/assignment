public class createContact {
 
    @AuraEnabled
    public static Contact createContact(Contact contact) {
        system.debug('contact'+contact);
        insert contact;
        return contact;
    }
}