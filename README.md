# Salesforce Non-Profit Donation & Volunteer Management

## Overview

This repository contains the source code for a comprehensive capstone project built on the Salesforce Platform. The application is designed to provide a 360-degree view of a non-profit organization's core operations by centralizing donation tracking and volunteer management into a single, efficient, and user-friendly system.

This project demonstrates a wide range of Salesforce administration, development, and data management skills, from initial org setup and data modeling to custom automation, Apex coding, Lightning Web Component development, and integration with external web services.

## Key Features

The application is built around a custom Lightning App, the "NGO Hub," which features a custom dashboard providing immediate access to key tools and insights.

### Donation Management

* **Foundation:** Leverages the **Nonprofit Success Pack (NPSP)** for its industry-standard data model, including Household Accounts and Donation (Opportunity) tracking.
* **Automated Updates:** An **Apex Trigger** automatically updates a `Last_Donation_Date__c` field on a Contact record whenever a new donation is created, providing real-time donor insights.
* **Automated Communications:** A **Record-Triggered Flow** automatically sends a personalized "Thank You" email to a donor as soon as their donation is marked as 'Posted'.

### Volunteer Management

* **Custom Data Model:** A custom data model was built to manage events and volunteer sign-ups, featuring custom objects (`Event__c`) and a junction object (`Volunteer_Hours__c`) to create a many-to-many relationship between Volunteers (`Contact`) and Events.
* **Guided Sign-Up Process:** A **Screen Flow** provides a user-friendly, wizard-style interface on the main dashboard for staff to quickly and accurately sign up volunteers for events.

### Custom User Experience & Tools

* **Custom Dashboard:** A custom "NGO Dashboard" was built using the Lightning App Builder to serve as the application's home page.
* **Real-time Statistics:** A custom **Lightning Web Component (`donationStats`)** displays a live count of the total number of donations by calling an Apex controller.
* **External Integration:** A second custom **LWC (`holidayPlanner`)** serves as an "Event Planning Helper." With one click, it makes a real-time Apex Callout to an external public API to fetch and display a list of public holidays, assisting with strategic event scheduling.

### Analytics & Data Quality

* **Custom Reports & Dashboards:** Custom report types, reports (`Donations by Month`, `Volunteer Sign-Ups by Event`), and an "NGO Executive Dashboard" were built to provide leadership with at-a-glance insights into fundraising trends and volunteer engagement.
* **Data Integrity:** A **Duplicate Rule** (powered by a custom **Matching Rule** on the Email field) was implemented to prevent the creation of redundant contact records, ensuring high data quality.
* **Bulk Data Loading:** The project utilizes **Salesforce Data Loader** for importing records, demonstrating the ability to manage large data sets.

## Technical Implementation Details

This project was built using modern, best-practice Salesforce technologies and design patterns.

* **Platform:** Salesforce Lightning Experience
* **Foundation:** Nonprofit Success Pack (NPSP)
* **Data Model:** Custom Objects, Master-Detail Relationships, Junction Objects
* **Automation:** Salesforce Flow (Record-Triggered & Screen Flow), Validation Rules
* **Backend Logic:** Apex Triggers (using a Handler Class Pattern), Apex Classes, SOQL
* **Frontend UI:** Lightning Web Components (LWC), Lightning App Builder
* **Integration:** REST API Callouts from Apex, Remote Site Settings
* **Data Management:** Salesforce Data Loader, Duplicate & Matching Rules
* **Analytics:** Custom Report Types, Reports, and Dashboards
* **Development Tools:** Visual Studio Code, Salesforce CLI (SFDX), Git & GitHub

## Project Structure

The source code for this project is organized within the `force-app/main/default` directory, following standard SFDX project structure.

* `classes/`: Contains all custom Apex classes (Trigger Handlers, LWC Controllers).
* `lwc/`: Contains the source code for all custom Lightning Web Components.
* `objects/`: Contains the definitions for custom objects and fields.
* `flows/`: Contains the definitions for the Record-Triggered and Screen Flows.
* `reports/` & `dashboards/`: Contain the source for the custom reports and dashboards.
* `triggers/`: Contains the logic-less Apex Triggers.

## How to Deploy

This is an SFDX-format project. To deploy this project to a Salesforce org:

1.  Clone this repository to your local machine.
2.  Ensure you have the Salesforce CLI installed and configured.
3.  Authorize a Salesforce Developer Org (preferably one with the Nonprofit Success Pack installed).
4.  Use the command `sfdx force:source:deploy -p force-app` to deploy the metadata to your org.

**Author:** Monisha Dusanapudi
