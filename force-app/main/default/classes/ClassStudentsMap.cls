public class ClassStudentsMap {
  public static  Map<Id,Set<ID>> getClassStudentMap()
   {
       class__c[] cls = [select id,(select id from students__r) from class__C];
       
       Map<Id,Set<ID>> classStudentMap = new Map<Id,Set<ID>>();
       
       for(class__c clazz : cls)
       {
           Set<Id> studentIds = new Set<Id>();
           for(Student__c s : clazz.Students__r) {
               studentIds.add(s.Id);
           }
           classStudentMap.put(clazz.id,studentIds);
       }
       return classStudentMap;
   }
}