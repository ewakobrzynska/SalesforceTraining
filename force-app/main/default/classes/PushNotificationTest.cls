public class PushNotificationTest {
    @future(callout=true)
    public static void sendPushNotification(String endpointUrl) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpointUrl);
        req.setMethod('POST');
        Http http = new Http();
        HttpResponse res = http.send(req);
        System.debug('Response: ' + res.getBody());
    }

    public static void testPushLimit() {
        for (Integer i = 0; i < 1000; i++) { 
            sendPushNotification('https://example.com/push');
        }
    }
}