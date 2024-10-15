public class EmailInvocations {
    public static void EmailMethod() {
        for (Integer i = 0; i < 11; i++) {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] { 'google@gmail.com' });
            mail.setPlainTextBody('Test');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }
}