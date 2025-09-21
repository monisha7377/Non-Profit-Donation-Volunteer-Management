// This is the "Trigger". It automatically listens for database events.
trigger OpportunityTrigger on Opportunity (after insert) {

    // This trigger fires "after" a new donation has been "inserted" (created).
    // Its only job is to call our "brain" class and tell it to run its logic.
    OpportunityTriggerHandler.updateLastDonationDate(Trigger.new);
}