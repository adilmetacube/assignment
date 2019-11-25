public class ContactInsertUpdate {
    
    public void doIt(){
   
// Upsert the contact by using the idLookup field for matching.
//upsert jane2 Contact.fields.Email;
// Verify that the contact has been updated
//System.assertEquals('Prefers to be contacted by email.',
                   //[SELECT Description FROM Contact WHERE Id=:jane.Id].Description);
                   System.debug('[SELECT Description FROM Contact WHERE Id=:jane.Id].Description');
           

    }
}