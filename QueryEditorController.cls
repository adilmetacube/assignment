public  with sharing class  QueryEditorController {
    public String query {get; set;}
    public Boolean recordToshow {get;set;}
    public QueryEditorController(){
        
    }
    
    public void executeQuery(){
        recordToshow=true;
        
    }
    
}
