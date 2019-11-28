Trigger OpportunityTrigger on Opportunity(BEFORE INSERT,BEFORE UPDATE){
	if (Trigger.IsBefore && Trigger.isInsert) {
		for (Opportunity objOpportunity:Trigger.New) {
			if (objOpportunity.StageName == 'CLOSED_WON' || objOpportunity.StageName == 'CLOSED_LOST') {
				objOpportunity.CloseDate = System.Today();
			}
		}
	}
	if (Trigger.IsBefore && Trigger.isUpdate) {
		for (Opportunity objOpportunity:Trigger.New) {
			if (objOpportunity.StageName != Trigger.OldMap.Get(objOpportunity.Id).StageName && (objOpportunity.StageName == 'CLOSED_WON' || objOpportunity.StageName == 'CLOSED_LOST')) {
				objOpportunity.CloseDate = System.Today();
			}
		}
	}
	
}