// This is the final, production-ready version of the Apex controller.
public with sharing class HolidayFetcherController {

    // Our Holiday "blueprint" class. The variable name is holidayDate to avoid conflicts.
    public class Holiday {
        @AuraEnabled public Date holidayDate {get; set;}
        @AuraEnabled public String localName {get; set;}
    }

    @AuraEnabled(cacheable=true)
    public static List<Holiday> getHolidays() {
        HttpRequest request = new HttpRequest();
        Integer currentYear = Date.today().year();
        // We use the US country code to ensure we get data.
        request.setEndpoint('https://date.nager.at/api/v3/PublicHolidays/' + currentYear + '/US');
        request.setMethod('GET');

        Http http = new Http();
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            // --- THIS IS THE CRITICAL FIX FOR THE MISSING DATES ---
            // We manually parse the response to avoid any naming conflicts with reserved words.
            List<Object> untypedHolidays = (List<Object>) JSON.deserializeUntyped(response.getBody());
            List<Holiday> typedHolidays = new List<Holiday>();

            for (Object untypedHoliday : untypedHolidays) {
                Map<String, Object> holidayMap = (Map<String, Object>) untypedHoliday;
                Holiday h = new Holiday();
                // The API returns the date as a string 'YYYY-MM-DD'. We must parse it into a real Date.
                h.holidayDate = Date.valueOf((String)holidayMap.get('date'));
                h.localName = (String) holidayMap.get('localName');
                typedHolidays.add(h);
            }
            return typedHolidays;

        } else if (response.getStatusCode() == 204) {
            return new List<Holiday>();
        } else {
            throw new AuraHandledException('Callout to Holiday API failed with status code: ' + response.getStatusCode());
        }
    }
}