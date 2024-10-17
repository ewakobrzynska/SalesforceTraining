public class EventPublisher {
    public static void EventMethod(){
        MyPlatformEvent__e event = new MyPlatformEvent__e();
        for(Integer i=0; i<151;i++){
            EventBus.publish(event);
        }
    }
}