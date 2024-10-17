public without sharing class LeadController {
  public LeadController() {
  }

  public PageReference getSubmitForm() {
    return null;
  }

  public PageReference submitForm() {
    Lead lead = new Lead();
    lead.FirstName = ApexPages.currentPage().getParameters().get('first_name');
    lead.LastName = ApexPages.currentPage().getParameters().get('last_name');
    String phone = ApexPages.currentPage().getParameters().get('phone');
    lead.Phone = '+48 ' + phone;
    lead.Email = ApexPages.currentPage().getParameters().get('email');
    lead.Company = ApexPages.currentPage().getParameters().get('company');
    insert lead;
      System.debug(lead);
    return null;
  }
}