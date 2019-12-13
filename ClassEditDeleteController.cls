public class ClassEditDeleteController {
    
    public List<Class__c> classList { get; set; }
    public List<Class__c> editclassDetails { get; set; }
    public String parentId { get; set; }
    public Boolean editStatus{ get; set; }
 
    
    
    public ClassEditDeleteController() {
        LoadData();
    }
    
    private void LoadData() {
        classList = [SELECT Id, Name, ClassTeacher__c,Max__c from Class__c limit 10];
    }
    
    public void editClassDetails(){
        editStatus=true;
          system.debug('parentId :' + parentId);
       string searchquery='Select id, name, ClassTeacher__c,Max__c from Class__c where id=\''+parentId+'\'';
        System.debug('searchquery--:'+searchquery);
        editclassDetails =    Database.query(searchquery);
         System.debug('editDetails-------'+editclassDetails);
    }
    
    public void deleteClass(){
        system.debug('parentId :' + parentId);
        Class__c classObject= [SELECT Id,Name FROM Class__c WHERE Id =:parentId];
        if (classObject != null) {
             system.debug('In if');
            Delete classObject;
            LoadData();
        }
    }
    
    public void saveClass(){
        editStatus=false;
        System.debug(' editclassDetails------'+editclassDetails);
        update editclassDetails;
          LoadData();
    }
    
    
}