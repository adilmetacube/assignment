trigger Cannot_Delete_Class_If_Female_Student_exist on Class__c (before delete) {
    List<Class__c> classList=[select name,(select First_Name__c,Date_of_Birth__c,Sex__c from Students__r) from Class__c where id  IN :Trigger.old ];
     	Integer femaleStudentCount;
        for(Class__c c : classList){    
        for (Student__c r: c.Students__r) {
            if(r.Sex__c=='Female'){
                femaleStudentCount++;
            }
        }
            if(femaleStudentCount>1){
             Trigger.oldMap.get(c.id).adderror('This class can not be deleted');
                }
     }     
}