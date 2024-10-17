public class ExternalServiceClient {
    private static final String CONSUMER_KEY = '3MVG9PwZx9R6_Urc9Ty6souigr_9oUUX.coJHk86tXEh89UALwYVn2bvv7.qieD9u81dryB_b9rujkDk_Gshi';
    private static final String CONSUMER_SECRET = '930EB935661DBE60771DA7553A855D4FFDD26974B9D2BDC818C0B80655CF7735';
    private static final String AUTH_URL = 'https://login.salesforce.com/services/oauth2/token';

    @future(callout=true)
    public static void makeCallout() {
        // Uzyskiwanie tokenu dostępu
        String accessToken = getAccessToken();

        if (accessToken == null) {
            System.debug('Access Token is null');
            return;
        }

        // Przygotowanie żądania
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://your-external-service.com/api');
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + accessToken);
        req.setHeader('Content-Type', 'application/json');
        req.setBody('{"key":"value"}');

        Http http = new Http();
        HttpResponse res = http.send(req);

        System.debug('Response: ' + res.getBody());
    }

    private static String getAccessToken() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(AUTH_URL);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setBody('grant_type=client_credentials&client_id=' + CONSUMER_KEY + '&client_secret=' + CONSUMER_SECRET);

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            return (String) result.get('access_token');
        } else {
            System.debug('Failed to get access token. Status: ' + res.getStatusCode());
            return null;
        }
    }
}