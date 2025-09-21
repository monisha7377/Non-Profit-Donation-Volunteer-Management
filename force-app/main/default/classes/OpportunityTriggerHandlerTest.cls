// This tells Salesforce this code is for testing only.
@isTest
private class OpportunityTriggerHandlerTest {

    @isTest
    static void testUpdateLastDonationDate() {
        // 1. ARRANGE: Create our test data.
        Contact testContact = new Contact(LastName = 'Test Donor');
        insert testContact; // Save it to the database.

        // 2. ACT: Run the code we want to test.
        Test.startTest();
        // Create a fake Opportunity (donation) and link it to our fake donor.
        // The "insert" command here is what causes our real trigger to fire.
        Opportunity testOpp = new Opportunity(
            Name = 'Test Donation',
            StageName = 'Posted',
            Amount = 100,
            CloseDate = Date.today(),
            npsp__Primary_Contact__c = testContact.Id
        );
        insert testOpp;
        Test.stopTest();

        // 3. ASSERT: Verify the result was correct.
        // Get the Contact record back from the database to see if it was updated by our code.
        Contact updatedContact = [SELECT Last_Donation_Date__c FROM Contact WHERE Id = :testContact.Id];

        // Assert that the "Last Donation Date" is now equal to today's date.
        // If it is, the test passes. If it's not, the test fails.
        System.assertEquals(Date.today(), updatedContact.Last_Donation_Date__c, 'The Last Donation Date should be updated to today.');
    }
}