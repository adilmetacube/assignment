public class StudentsInClass {
    public static List<Student__c> getStudentsList(String className){
        List<Student__c> studentList=[SELECT Name FROM Student__c where Class__c=:className];
        return studentList;
    } 
}