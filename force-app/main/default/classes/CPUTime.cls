public class CPUTime {
    public static void CPUMethod() {
        Long sum = 0;
        for (Integer i = 0; i < 10000000; i++) {
            sum += i;
        }
    }
}