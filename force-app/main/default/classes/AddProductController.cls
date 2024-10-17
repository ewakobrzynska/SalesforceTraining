public with sharing class AddProductController {
    @AuraEnabled
    public static List<Product2> getProducts(String searchKey) {
        return [SELECT Id, Name FROM Product2];
    }

    @AuraEnabled
    public static Order createOrder(List<String> productIds, Id opportunityId) {
        Order newOrder = new Order();
        newOrder.OpportunityId = opportunityId;
        insert newOrder;

        return newOrder;
    }
}