global class CreateContactFrmEmail implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        String subToCompare = 'Create Contact';
        if(email.subject.equalsIgnoreCase(subToCompare))
        {
            for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
                Attachment attachment = new Attachment();
                attachment.Name = tAttachment.fileName;
                Blob myBlob = Blob.valueOf(tAttachment.body);
                XMLparse xmlParse= new XMLparse();
                xmlParse.parseXML(myBlob.toString());
            }
        }
        result.success = true;
        return result;
    }
    
    
}
