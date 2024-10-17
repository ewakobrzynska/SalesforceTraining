public class SOQLQueries {
    public static void SOQLMethod() {
        for (Integer i = 0; i < 101; i++) {
            Account account = [
                    SELECT Name
                    FROM Account
                	LIMIT 1
            ];
        }
    }
}