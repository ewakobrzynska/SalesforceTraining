trigger OrderProcessEventTrigger on Order_Process_Event__e (after insert) {
    for (Order_Process_Event__e event : Trigger.New) {
        try {
            Order ord = [SELECT Id, Status FROM Order WHERE Id = :event.OrderId_c__c LIMIT 1];
            ord.Status = 'Retry Processing';
            update ord;
        } catch (Exception e) {
            System.debug('Error processing order event: ' + e.getMessage());
        }
    }
}