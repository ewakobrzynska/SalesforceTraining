public with sharing class AddProductController {
    @AuraEnabled
    public static List<Product2> getProducts(String searchKey) {
        return [SELECT Id, Name FROM Product2];
    }
}