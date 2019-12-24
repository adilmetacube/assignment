public   class ContactController {
     @AuraEnabled
    public static Contact save(contact con)
    {
     insert con;
        return con;
    }
}
