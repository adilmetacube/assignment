public class QueryEditorComponentController {
    
    public string query {get;set;}
    public string queryError{get;set;}
    public List<string> FieldList{get;set;}
    public String numberOfRecords='10';
    private integer counter=0;  //keeps track of the offset
    private integer list_size=10; //sets the page size or number of rows
    public integer total_size; //used to show user the total size of the list
    private String sortDirection = 'ASC';
    private String sortExp = 'name';
    public String sortExpression
    {
        get
        {
            return sortExp;
        }
        set
        {
            //if the column is clicked on then switch between Ascending and Descending modes
            if (value == sortExp)
                sortDirection = (sortDirection == 'ASC')? 'DESC' : 'ASC';
            else
                sortDirection = 'ASC';
            sortExp = value;
        }
    }
    
    public QueryEditorComponentController(){
        FieldList = new List<string>();
    }
    
    public String getSortDirection()
    {
        //if not column is selected 
        if (sortExpression == null || sortExpression == '')
            return 'ASC';
        else
            return sortDirection;
    }
    
    public void setSortDirection(String value)
    {  
        sortDirection = value;
    }
    
    
    public List<SObject>  getdataFromQuery(){
        List<SObject> sObj=new List<SObject>();
        string sortFullExp = sortExpression  + ' ' + sortDirection;
        String queryCheck=query.toLowerCase().substringBetween('select ', ' from ');
        if(queryCheck!=null){
            FieldList =queryCheck.replaceAll('\\s','').split(',');    
            System.debug('--FieldList--'+ FieldList);
            queryError=query;
            try{
                sObj=Database.query(query);
                total_size=sobj.size();
                if(query.contains('where')){
                    query=query+' order by '+sortFullExp+' Limit '+numberOfRecords;    
                }else{
                    query=query+' order by '+sortFullExp+' Limit '+numberOfRecords+ ' offset '+counter;
                }
                sObj=Database.query(query);
                query='';
                
            }catch(System.QueryException e){
                queryError=e.getMessage();
            }
        }else{
            queryError='incorrect query';
            sObj=null;
        }
        return sObj;
        
    }
    
    public PageReference ViewData() {
        getdataFromQuery();
        return null;
    }
    
    public PageReference Beginning() { //user clicked beginning
        counter = 0;
        return null;
    }
    
    public PageReference Previous() { //user clicked previous button
        counter -= list_size;
        getdataFromQuery();
        return null;
    }
    
    
    public PageReference Next() { //user clicked next button
        counter += list_size;
        getdataFromQuery();
        return null;
    }
    
    
    public PageReference End() { //user clicked end
        counter = total_size - math.mod(total_size, list_size);
        getdataFromQuery();
        return null;
    }
    
    public Boolean getDisablePrevious() { 
        //this will disable the previous and beginning buttons
        if (counter>0) return false; else return true;
    }
    public Boolean getDisableNext() { //this will disable the next and end buttons
        if (counter + list_size < total_size) return false; else return true;
    }
    public Integer getTotal_size() {
        return total_size;
    }
    public Integer getPageNumber() {
        return counter/list_size + 1;
    }
    public Integer getTotalPages() {
        if (math.mod(total_size, list_size) > 0) {
            return total_size/list_size + 1;
        } else {
            return (total_size/list_size);
        }
    }
    
}
