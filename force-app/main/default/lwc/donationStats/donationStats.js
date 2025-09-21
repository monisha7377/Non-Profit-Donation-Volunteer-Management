import { LightningElement, wire } from 'lwc';
// Import the Apex method we created.
import getTotalDonations from '@salesforce/apex/DonationStatsController.getTotalDonations';

export default class DonationStats extends LightningElement {
    // Use the @wire service to call our Apex method.
    // The result will automatically be put into the totalDonations variable.
    @wire(getTotalDonations)
    totalDonations;
}