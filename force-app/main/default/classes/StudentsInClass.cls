public class StudentsInClass {
    public static List<Student__c> studentListInClass(String className){
        List<Student__c> studentList=[select name from Student__c where class__c=:className];
         system.debug('student list : '+ studentList);
        return studentList;
    } 
}