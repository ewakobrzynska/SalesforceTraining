public class DMLStatements {
    public static void DMLMethod() {
        for (Integer i = 0; i < 151; i++) {
            Account account = new Account(
                    Name = 'Account ' + i
            );
            insert account;
        }
    }
}