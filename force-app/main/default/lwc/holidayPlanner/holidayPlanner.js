import { LightningElement, track } from 'lwc';
import getHolidays from '@salesforce/apex/HolidayFetcherController.getHolidays';

export default class HolidayPlanner extends LightningElement {
    @track holidays;
    @track error;
    // THE FIX: This variable is used by the HTML for the title.
    displayYear = new Date().getFullYear();

    handleFetchHolidays() {
        this.holidays = undefined;
        this.error = undefined;

        getHolidays()
            .then(result => {
                this.holidays = result;
                if (result.length === 0) {
                    this.error = 'No holidays found for this year.';
                }
            })
            .catch(error => {
                if (error && error.body && error.body.message) {
                    this.error = 'Error: ' + error.body.message;
                } else {
                    this.error = 'An unknown error occurred.';
                }
            });
    }
}