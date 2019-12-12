@isTest
public class TestOpportunityTrigger {
    @isTest static void updateOppClosedDate(){
        Opportunity oppObject = new Opportunity(Name=' Opportunity 1',
                                       StageName='CLOSED_WON');
        insert oppObject;
        
        List<Opportunity> oppList=[select CloseDate from Opportunity where id =:oppObject.Id ];
        for(Opportunity oppListObject:oppList){
            System.assertEquals(System.Today(),oppListObject.CloseDate);
        }
           Opportunity oppObjectUpdated = new Opportunity(Id=oppObject.Id,Name=' Opportunity 1',
                                       StageName='CLOSED_LOST');
        upsert oppObjectUpdated;
        List<Opportunity> oppListUpdated=[select CloseDate from Opportunity where id =:oppObjectUpdated.Id ];
        for(Opportunity oppListObject:oppListUpdated){
            System.assertEquals(System.Today(),oppListObject.CloseDate);
        }
        
        
        
    }
}
