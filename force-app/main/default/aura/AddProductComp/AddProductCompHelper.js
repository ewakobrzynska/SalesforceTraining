({
    fetchProducts: function(component) {
        var action = component.get("c.getProducts");
        action.setParams({
            visitedCountries: component.get("v.visitedCountries") || ''
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var products = response.getReturnValue();
                products.forEach(function(product) {
                    if (!product.quantity) {
                        product.quantity = 1;  
                    }
                });
                console.log('Fetched Products:', products);
                component.set("v.products", products);
            } else if (state === "ERROR") {
                console.error('Error fetching products: ', response.getError());
            }
        });
        $A.enqueueAction(action);
    },
    
    filterProducts: function(component) {
        this.fetchProducts(component); 
    }
})