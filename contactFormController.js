({
savecontact: function(component, event, helper) {
    var newcon = component.get("v.newContact");
    var action = component.get("c.save");
     action.setParams({ 
        "con": newcon
    });
     action.setCallback(this, function(a) {
           var state = a.getState();
            if (state === "SUCCESS") {
                var name = a.getReturnValue();
               alert("success");
            }
         else
         {
              alert("Failed");
         }
        });
    $A.enqueueAction(action)
},
clickCreateContact: function(component, event, helper) {
		
        var validForm = component.find("contactField").reduce(function(validSoFar, inputCmp){
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;},true);
    
        if(validForm)
        {    console.log('validForm',validForm);
           var contact = component.get("v.newContact");
            helper.savecontact(component,contact)
           
	}
}})
