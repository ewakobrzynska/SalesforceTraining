public class QueueablePushNotification implements Queueable {
    public void execute(QueueableContext context) {
    }

    public static void addQueueableJobs() {
        for (Integer i = 0; i < 55; i++) {
            System.enqueueJob(new QueueablePushNotification());
        }
    }
}