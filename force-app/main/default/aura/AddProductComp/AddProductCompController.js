({
    doInit: function(component, event, helper) {
        var recordId = component.get("v.recordId");
        component.set("v.opportunityId", recordId);  
        
        console.log("Opportunity ID during init:", recordId);
        component.set('v.columns', [
            { label: 'Product Name', fieldName: 'Name', type: 'text' },
            { label: 'Visited Countries', fieldName: 'Visited_Countries__c', type: 'text' },
            { label: 'Price', fieldName: 'UnitPrice', type: 'currency' },
            { label: 'Quantity', fieldName: 'Quantity', type: 'number', editable: true }  
        ]);
        component.set('v.summaryColumns', [
            { label: 'Product Name', fieldName: 'Name', type: 'text' },
            { label: 'Price', fieldName: 'UnitPrice', type: 'currency' },
            { label: 'Quantity', fieldName: 'Quantity', type: 'number' }
        ]);     
        
        helper.fetchProducts(component);
    },
    
    filterProducts: function(component, event, helper) {
        helper.filterProducts(component); 
    }, 
    
    handleQuantityChange: function(component, event, helper) {
        var productQuantity = event.getParam('productQuantity');
        var products = component.get("v.products");
    
        productQuantity.forEach(function(productQuantity) {
            var index = products.findIndex(product => product.Id === productQuantity.Id);
            if (index !== -1) {
                products[index].Quantity = productQuantity.Quantity || 1;
            }
        });
    
        component.set("v.products", products); 
    },
    
    handleRowSelection: function(component, event, helper) {
        console.log('Event: ', event);
        var selectedRows = event.getParam('selectedRows');
        console.log('Selected Rows: ', selectedRows);
        var products = component.get("v.products");
        console.log('Products: ', products);

        selectedRows.forEach(function(selectedProduct) {
            var product = products.find(p => p.Id === selectedProduct.Id);
            if (product && product.quantity) {
                selectedProduct.quantity = product.quantity; 
            } else {
                selectedProduct.quantity = 1; 
            }
        });
        console.log('Selected Products: ', component.get("v.selectedProducts"));
        
        component.set("v.selectedProducts", selectedRows);
        component.set("v.showSummary", selectedRows.length > 0);
        console.log('Show Summary: ', component.get("v.showSummary"));
    },
    
    closeAsWon: function(component, event, helper) {
        var selectedProducts = component.get("v.selectedProducts").map(product => {
            return {
                Id: product.Id,
                UnitPrice: product.UnitPrice 
            };
        });
        
        var opportunityId = component.get("v.opportunityId");
        console.log("Opportunity ID:", opportunityId);
        if (!opportunityId) {
            console.error("Opportunity ID is null or undefined. Cannot close opportunity.");
            return; 
        }
    
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