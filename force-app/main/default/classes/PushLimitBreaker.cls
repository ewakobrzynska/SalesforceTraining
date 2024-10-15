public class PushLimitBreaker {
    @future(callout=true)
    public static void makePushCall() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://your-external-service.com/api');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody('{"key":"value"}');
        
        Http http = new Http();
        HttpResponse res = http.send(req);
    }

    public static void breakPushCallLimit() {
        for (Integer i = 0; i < 1000; i++) {
            makePushCall();
        }
    }
}