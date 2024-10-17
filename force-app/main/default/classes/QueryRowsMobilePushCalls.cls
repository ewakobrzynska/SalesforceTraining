public class QueryRowsMobilePushCalls {
    public static void MobileMethod() {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { UserInfo.getUserEmail() });
        mail.setSubject('Notification Title');
        mail.setPlainTextBody('Notification Title');

        // Wysyłanie wiadomości
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    }
}