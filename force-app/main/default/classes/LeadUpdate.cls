public class LeadUpdate {
    public static void updateLeads() {
        List<Opportunity> leads = [
            SELECT Id 
            FROM Opportunity
            
        ];
        if (!leads.isEmpty()) {
            update leads;
        }
    }
}