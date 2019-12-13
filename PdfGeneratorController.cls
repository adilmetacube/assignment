public with sharing class PdfGeneratorController {
    
    public ID parentId {get;set;}
    public String pdfName {get;set;}
    
    public PageReference savePdf() {
        deleteAttachment();
        PageReference pdf = Page.PdfGeneratorTemplate;
        pdf.getParameters().put('id',parentId);      
        Attachment attach = new Attachment();     
        Blob body;      
        try { 
            body = pdf.getContent();
        } catch (VisualforceException e) {
            body = Blob.valueOf('Some Text');
        }   
        attach.Body = body;
        attach.Name = pdfName;
        attach.IsPrivate = false;
        attach.ParentId = parentId;
        insert attach;      
        return new PageReference('/'+parentId);      
    }
    public void deleteAttachment()
    {
        List<Attachment> attachmentList=new List<Attachment>();
        for(Student__c studentObj:[SELECT Id ,(SELECT Id FROM Attachments) FROM Student__c WHERE Id=:parentId]){
            attachmentList=studentObj.Attachments;
        }
        delete attachmentList;
    }
    
}