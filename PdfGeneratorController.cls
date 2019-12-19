public with sharing class PdfGeneratorController {
    
    public ID parentId {get;set;}
    public String pdfName {get;set;}
    
    
    public PdfGeneratorController(){
        parentId=apexpages.currentpage().getparameters().get('id');
        pdfName=String.valueOf(parentId)+'.pdf';
    }
    
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
        for(Attachment attch:[SELECT Id,Name,ParentId FROM Attachment  WHERE ParentId=:parentId]){
            if(attch.name==pdfName){
                attachmentList.add(attch);
            }
        }
        delete attachmentList;
    }
    
}
