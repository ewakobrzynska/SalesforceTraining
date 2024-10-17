public class PushCallTest {
    @future(callout=true)
    public static void sendPushNotification(String endpoint) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody('{"message": "Test push notification"}');
        
        Http http = new Http();
        HttpResponse res = http.send(req);
    }
    
    public static void triggerPushCalls() {
        for (Integer i = 0; i < 200; i++) { // Ustaw liczbę większą niż limit
            sendPushNotification('https://your-endpoint-url.com');
        }
    }
}