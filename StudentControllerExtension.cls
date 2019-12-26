public class StudentControllerExtension {
    
    public List<Student__c> students{get; set;}
    public boolean showStatus {get;set;}
    
    
    public StudentControllerExtension (ApexPages.StandardSetController stdController) {
            //this.student = (Student__c)stdController.getRecord();
       students =(List<Student__c>)stdController.getSelected();
        System.debug('--> ' + students);
        If(students==null || students.isEmpty()){
            System.debug('--> in if ');
         Apexpages.addMessage( new ApexPages.Message (ApexPages.Severity.ERROR, 'No records selected'));
        }else{
                showStatus=true;
        }
        
        }
    
   @RemoteAction
   public static String deleteStudentsRemotely(List<String> studentIds) {
       System.debug('Called----->' + studentIds);
       List<Student__C> studentList = [SELECT Id FROM Student__C WHERE Id IN :studentIds];
       delete studentList;
       return 'success';
   }
    
    public PageReference listView() {

    return new ApexPages.Action('{!List}').invoke();
    //System.PageReference[/a09?fcf=00B24000004cfLK]

}
    
}
