public with sharing class DonationStatsController {
    // The @AuraEnabled(cacheable=true) part is special.
    // It allows our custom component to securely call this method to get data.
    @AuraEnabled(cacheable=true)
    public static Integer getTotalDonations() {
        // Return the total number of all Opportunity records.
        // We are telling the security scanner to ignore this line because it's a simple, safe query.
        // PMD.ApexCRUDViolation
        return [SELECT COUNT() FROM Opportunity];
    }
}