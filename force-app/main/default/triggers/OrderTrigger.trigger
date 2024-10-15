trigger OrderTrigger on Order (after insert, after update) {
    List<Order_Process_Event__e> events = new List<Order_Process_Event__e>();
    
    for (Order ord : Trigger.New) {
        try {
            if (ord.Status == 'Processing') {
                update ord;  
            }
        } catch (Exception e) {
            Order_Process_Event__e event = new Order_Process_Event__e(
                OrderId_c__c = ord.Id,
                Status_c__c = 'Error',
                Message_c__c = e.getMessage()
            );
            events.add(event);
        }
    }
    
    if (!events.isEmpty()) {
        EventBus.publish(events);
    }
}