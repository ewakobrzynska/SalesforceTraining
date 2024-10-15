trigger AccountTrigger on Account (after insert, after update) {
    for (Account account : Trigger.new) {
        System.debug('Trigger fired for Account: ' + account.Id);
    }
}