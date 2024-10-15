trigger MyPlatformEventTrigger on MyPlatformEvent__e (after insert) {
    List<Account> accountsToInsert = new List<Account>();

    for (MyPlatformEvent__e event : Trigger.New) {
        Account account = new Account();
        account.Name = event.EventField1__c;
        accountsToInsert.add(account);
    }

    insert accountsToInsert;
}