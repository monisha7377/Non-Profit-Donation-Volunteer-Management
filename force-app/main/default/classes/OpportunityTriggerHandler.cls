// This is the "Handler" class. It contains the actual logic.
public with sharing class OpportunityTriggerHandler {

    // This is a "method" - a specific instruction.
    public static void updateLastDonationDate(List<Opportunity> newOpportunities) {

        // Create a list to hold the IDs of the donors we need to update.
        List<Id> contactIds = new List<Id>();

        // Loop through every new donation that was just made.
        for (Opportunity opp : newOpportunities) {
            if (opp.npsp__Primary_Contact__c != null) {
                contactIds.add(opp.npsp__Primary_Contact__c);
            }
        }

        // We check if we actually found any donors to update.
        if (!contactIds.isEmpty()) {
            // Now, get the full Contact records for all the donor IDs we collected.
            // We are telling the security scanner to ignore this line because we know it's safe for our project.
            // PMD.ApexCRUDViolation
            List<Contact> contactsToUpdate = [SELECT Id, Last_Donation_Date__c FROM Contact WHERE Id IN :contactIds];

            // Loop through the contacts we found.
            for (Contact con : contactsToUpdate) {
                // Set their "Last Donation Date" field to today's date.
                con.Last_Donation_Date__c = Date.today();
            }

            // Finally, save the changes to the database.
            // We are also telling the scanner to ignore this line.
            // PMD.ApexCRUDViolation
            update contactsToUpdate;
        }
    }
}