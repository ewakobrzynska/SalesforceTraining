public with sharing class GetOrgInfo {
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getOrgInfo() {
        Map<String, Object> orgInfo = new Map<String, Object>();

        List<ApexClass> apexClasses = [
            SELECT Id, Name, ApiVersion, Status, LastModifiedDate, LastModifiedBy.Name
            FROM ApexClass
        ];
        
        List<Map<String, Object>> apexClassList = new List<Map<String, Object>>();
        for (ApexClass apexClass : apexClasses) {
            Map<String, Object> apexClassData = new Map<String, Object>();
            apexClassData.put('Id', apexClass.Id);
            apexClassData.put('Name', apexClass.Name);
            apexClassData.put('ApiVersion', apexClass.ApiVersion);
            apexClassData.put('Status', apexClass.Status);
            apexClassData.put('LastModifiedDate', apexClass.LastModifiedDate);
            apexClassData.put('LastModifiedBy', apexClass.LastModifiedBy.Name);
            apexClassList.add(apexClassData);
        }
        
        orgInfo.put('apexClasses', apexClassList);

        List<User> users = [
            SELECT Id, Username, Email, IsActive, UserType, Name
            FROM User 
        ];
        orgInfo.put('users', users);

        List<UserLicense> licenses = [
            SELECT Id, LicenseDefinitionKey, TotalLicenses, UsedLicenses, Name
            FROM UserLicense
        ];
        orgInfo.put('licenses', licenses);

        return orgInfo;
    }
}