public class WebToLeadController {
    public String orgId { get; set; }

    public WebToLeadController() {
        WebToLeadSettings__c settings = WebToLeadSettings__c.getInstance('Default');
        if (settings != null) {
            orgId = settings.OrgId__c;
        } else {
            orgId = ''; 
        }
    }
}