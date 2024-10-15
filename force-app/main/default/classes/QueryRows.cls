public class QueryRows {
    public static void QueryMethod() {
        for (Integer i = 0; i < 100; i++) {
            List<Account> accounts = [
                    SELECT Name
                    FROM Account
            ];
        }
    }
}