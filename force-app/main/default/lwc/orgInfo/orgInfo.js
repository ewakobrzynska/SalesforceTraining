import { LightningElement, track } from 'lwc';
import getOrgInfo from '@salesforce/apex/GetOrgInfo.getOrgInfo';
import { NavigationMixin } from 'lightning/navigation';

export default class OrgInfo extends NavigationMixin(LightningElement) {
    @track apexClasses;
    @track users;
    @track licenses;
    @track error;

    apexColumns = [
        {
            label: 'Name',
            fieldName: 'apexClassUrl',
            type: 'url',
            typeAttributes: { label: { fieldName: 'Name' }, target: '_blank' }
        },
        { label: 'API Version', fieldName: 'ApiVersion', type: 'number' },
        { label: 'Status', fieldName: 'Status' },
        { 
            label: 'Last Modified Date', 
            fieldName: 'LastModifiedDate', 
            type: 'date', 
            typeAttributes: {
                year: "numeric",
                month: "2-digit",
                day: "2-digit",
                hour: "2-digit",
                minute: "2-digit",
                second: "2-digit",
                timeZone: "UTC",
                hour12: false 
            }
        },        
        { label: 'Last Modified By', fieldName: 'LastModifiedBy', type: 'text' },
    ];

    userColumns = [
        {
            label: 'Username',
            fieldName: 'userUrl',
            type: 'url',
            typeAttributes: { label: { fieldName: 'Username' }, target: '_blank' }
        },

        { label: 'Email', fieldName: 'Email' },
        { label: 'IsActive', fieldName: 'IsActive' },
        { label: 'UserType', fieldName: 'UserType' }
    ];

    licenseColumns = [
        {
            label: 'License Name',
            fieldName: 'licenseUrl',
            type: 'url',
            typeAttributes: { label: { fieldName: 'Name' }, target: '_blank' }
        },
        { label: 'License Definition Key', fieldName: 'LicenseDefinitionKey' },
        { label: 'Total Licenses', fieldName: 'TotalLicenses', type: 'number' },
        { label: 'Used Licenses', fieldName: 'UsedLicenses', type: 'number' },
    ];

    loadOrgInfo() {
        getOrgInfo()
            .then(result => {
                this.apexClasses = result.apexClasses.map(apexClass => {
                    return {
                        ...apexClass,
                        apexClassUrl: `/lightning/r/ApexClass/${apexClass.Id}/view`
                    };
                });
                this.users = result.users.map(user => {
                    return {
                        ...user,
                        userUrl: `/lightning/r/User/${user.Id}/view`
                    };
                });
                this.licenses = result.licenses.map(license => {
                    return {
                        ...license,
                        licenseUrl: `/lightning/r/UserLicense/${license.Id}/view`
                    };
                });
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.apexClasses = undefined;
                this.users = undefined;
                this.licenses = undefined;
            });
    }

    connectedCallback() {
        this.loadOrgInfo();
    }
}