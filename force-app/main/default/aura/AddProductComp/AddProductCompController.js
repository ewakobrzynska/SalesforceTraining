({
    doInit: function(component, event, helper) {
        component.set('v.columns', [
            { label: 'Product Name', fieldName: 'Name', type: 'text' },
            { label: 'Visited Countries', fieldName: 'Visited_Countries__c', type: 'text' },
            { label: 'Price', fieldName: 'UnitPrice', type: 'currency' }
        ]);
        component.set('v.summaryColumns', [
            { label: 'Product Name', fieldName: 'Name', type: 'text' },
            { label: 'Price', fieldName: 'UnitPrice', type: 'currency' }
        ]);     
        helper.fetchProducts(component);
    },
    
    filterProducts: function(component, event, helper) {
        helper.filterProducts(component); 
    },
    
    handleRowSelection: function(component, event, helper) {
        var selectedRows = event.getParam('selectedRows');
        component.set("v.selectedProducts", selectedRows);
        component.set("v.showSummary", selectedRows.length > 0);
    },
    
    closeAsWon: function(component, event, helper) {
        var selectedProducts = component.get("v.selectedProducts");
        var opportunityId = component.get("v.opportunityId");
        
        var action = component.get("c.closeOpportunity");
        action.setParams({
            opportunityId: opportunityId,
            products: selectedProducts
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("Opportunity closed as won and products added successfully!");
                $A.get('e.force:closeQuickAction').fire();
            } else if (state === "ERROR") {
                console.error("Error closing opportunity: ", response.getError());
            }
        });
        
        $A.enqueueAction(action);
    }
})