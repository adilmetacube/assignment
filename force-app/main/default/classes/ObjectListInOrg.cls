public class ObjectListInOrg {
    public static void objectListInOrg(){ 
        for(Schema.SObjectType objectList : Schema.getGlobalDescribe().Values()){
    system.debug('object list in org :'+ objectList.getDescribe().getLabel());
}    
    }
}