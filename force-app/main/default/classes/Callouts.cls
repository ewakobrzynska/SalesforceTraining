public class Callouts {
    public static void CalloutsMethod(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://www.apexdevnet.com');
        req.setMethod('GET');
        Http http = new Http();
        for (Integer i = 0; i < 101; i++) {
            http.send(req);
        }
    }
}