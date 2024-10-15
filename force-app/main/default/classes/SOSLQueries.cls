public class SOSLQueries {
    public static void SOSLMethod() {
        for (Integer i = 0; i < 21; i++) {
            List<List<Account>> accounts = [
                    FIND '%a%'
                    RETURNING Account(Name)
            ];
        }
    }
}