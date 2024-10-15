public class DMLRows {
    public static void DMLMethod(){
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10001; i++) {
            accounts.add(new Account(
                    Name = 'Test Account ' + i
            ));
        }
        insert accounts;
    }
}