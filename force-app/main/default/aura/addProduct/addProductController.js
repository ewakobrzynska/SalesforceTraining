({
    openModal: function(component, event, helper) {
        component.set("v.isModalOpen", true);
        helper.fetchProducts(component);
    },

    
    closeModal: function(component, event, helper) {
        component.set("v.isModalOpen", false);
    },

    handleProductSelection: function(component, event, helper) {
        helper.addProductToOrder(component, event);
    },

    handleProductSearch: function(component, event, helper) {
        helper.loadProducts(component);
    },

    handleCountryFilter: function(component, event, helper) {
        helper.loadProducts(component);
    },
})