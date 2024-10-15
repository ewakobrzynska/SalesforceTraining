public class FutureCalls {
    @future
    public static void futureMethod() {
    }
    
    public void scheduleFuture() {
        for (Integer i = 0; i < 51; i++) {
            futureMethod();
        }
    }
}