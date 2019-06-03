# Säntis Group

## Introduction
The Santis group is a grocery store that ships it's products to their customer's front door. Santis' customers put in their order through their smart speaker. This incoming order triggers the process of charging the customer's credit card. Once the order is fulfilled they receive an e-mail informing them that their package is on its way, and are provided with a tracking number so they can trace their package.

## Scenario
We took the scenario suggested by the lectures and adopted it into Säntis process. As it was suggested, the process can be split into four main process steps: order placement, receive payment, update inventory and order shipment.

<img width="900" alt="Structure" src="images/ServiceStructure.png">

1. The order placement starts when the customer makes their order. To place it, they will use their smart speaker such as Alexa or Google Home.
2. Once the speaker takes and executes the order, it will be saved to a Table on Google Drive to later be accessed and processed.
3. The order payment starts with the reading of the order from the Google Excel sheet and is inserted into the database. 
4. As a next step the price of the articles ordered will be read from the product table. Then the order amount is taken and multiplied by the price to result in the order sum in Talend.
5. The order sum is then subtracted from the client's credit card.
6. The next step of updating the inventory is done by reading the order amount and updating it in the product table of the database.
7. Lastly, the order shipment requires the generation of a tracking number which is then sent in an email to the customer, confirming the shipping of the order.

## Implementation
We designed the process as a choreography. Meaning that the sub-processes we would link among each other and not be delegated by a central brain. We chose to implement it this way because the order of the process steps was not going to change throughout this project. Additionally, implementing a process as a choreography brings the drawback of it being difficult to manage and maintain, this does not apply to our project since be do not plan on modifying it after completing the project. As to the disadvantage of it being difficult to monitor and track errors, we were able to avoid this because our project was small in size and complexity. Based on the way we implemented the process, the steps are of a synchronous nature, meaning that each process step has to be successfully completed for it to pass on to the next step. 

### Database
To implement the scenario we created a database for the project. The database has 5 tables: customer, product, orders, shipping and maxorder. The customer table contains the common attributes such as Name and address but also the customer's credit card number and balance. The product table holds the list of products with their prices and the amount on stock. The orders table and maxorder both hold the same attributes such as customer and order ID, product name and quantity as well as the order sum. The difference between these two is that the order table holds all orders made and entered into the database where as maxorder only contains the most current order that is being processed. Lastly, the shipping table holds the tracking number of the shipment but only not newest order.

### Order placement
* The first implementation step we did was the input of the order over the smart speaker. To simulate this, we use Dialogue Flow. In Dialogue Flow we created various intents such as 'Welcome' and 'Goodbye' to contain training words that the machine can recognize. We also created one that contained training phrases which would occur in our scenario.

    * <img width="700" alt="Dialogue Flow" src="images/DialogueFlow.PNG">

* To ensure the order entered in the Dialogue Flow will be processed, we linked it to the Integromat. In the Integromat we created a webhook and linked it to the Dialogue Flow. Through the webhook the order data will be taken and entered into a Google sheet.

    * <img width="700"  alt="Integromat" src="images/Integromat.PNG">

* The order data in the google sheet called Order_Listener will always be overwritten with the newest order.

    * <img width="500" alt="Google Sheet" src="images/GoogleTableOrder_Listener.PNG">

* To start the order placement task in Talend, the Google sheet has to be read by the program. For that to be possible, the file first has to be published to the Web. Then through the tFileFetch component it can be retrieved. The component is configured to read a specific protocol, in this case the protocol https, and given an URI link to access the wanted file. If the file is fetched successfully, the next part of the job is triggered.

    * <img width="900" alt="Order Placement" src="images/TalendOrderPlacementFileFetch.PNG">
    
* The next job extracts the order data from the file and inputs it into the table orders, which is located in the database. Due to the structure of the downloaded google sheet file, which is now a csv file, we use the tFileInputDelimited component. This component reads a given file row by row with simple separated fields. In our example the field separators is a “,”. 
The task of the next sub-job is for the newest line of the order table to be read and inputted into the maxorder. To make sure the last order made is read, the tAggregateRow component is used. It goes through the order_id column and looks for the largest number. The newest line is then entered into the maxorder table which at the same time overwrites the existing row in that table.

<img width="900" alt="Order Placement" src="images/TalendOrderPlacement.PNG">


### Payment Service

The next step is to collect payment from the customer. The ___ collects the order from ___ and matches the price to product through the max order, to calculate the order sum. This is calculated by multiplying the product price by the quantity ordered. If there is an error, then an e-mail is sent, identifying the problem. Through the process there are tlogs in place to ensure the service is working correctly. There are two database outputs in the payment service. One is to store the order sum in the order table and the other is to store it in the maxorder. To deduct the outstanding amount from the customers pre-existing balance, the max order table and customer table are joint through the customer ID. The order sum is subtracted from the customer's balance to make the payment. If however, there is not enough balance in the customer's account, then an additional 100 is added in the balance. The customer’s balance is then updated in the Customer table of the database.

<img width="900" alt="Calculate Price" src="images/TalendPriceCalculation.PNG">

<img width="900" alt="Service Finance" src="images/TalendServiceFinance.PNG">

<img width="900" alt="Receive Payment" src="images/TalendReceivePayment.PNG">

### Inventory Service

 <img width="900" alt="Inventroy Update" src="images/TalendUpdateInventory.PNG">

Before completing the purchase, the inventory is checked for availability. It fetches the maxorder and product tables and joins them through the product name attribute. It then finds the product stock from the product table and compares the amount to the quantity ordered. If the amount in stock is larger than the amount ordered, it subtracts the quantity ordered from the stock. This calculation is shown in the image below. 

 <img width="900" alt="Inventory Calculation" src="images/InventoryCalculation.png">

If however, the quantity ordered is less than the amount in stock, it will load 100 more products to the inventory. The inventory is then updated in the database.

### Order Shipment
The last step is the order shipment. This step requires the generation of a shipment ID for the customer’s order. The number is autogenerated when the order ID from maxorder table is entered into the shipping table. On the successful execution of that sub-job the shipment ID is read from the database. It is then embedded into an e-mail that is sent to the customer to inform them that their order in on its way.

<img width="900" alt="Order Shipment" src="images/TalendOrderShipment.PNG">

<img width="900" alt="Shipment Email" src="images/ShipmentEmail.PNG">

### Issues / Workarounds
During the development of our Enterprise Application Integration we encountered a variety of different problems and errors. Following there is a short description and the solution or workaround we chose for all major problems we faced.

* Installation of Talend
    * At the very beginning of the project, we had extreme difficulties to install the Talend software on our laptops. This might be due to the fact, that most members of our group are using a Macbook. Another reason could have been the unavailability of XAMP. We had to use MAMP instead which caused also problems with Talend.
    * As a solution we installed Talend on our PC at home and during the coaching lessons, where we worked on our project, established a TeamViewer connection to our Laptop. This way, a working Talend environment was ensured.

* Errormessage that caused Talend to crash
    * During the workprocess, an error message showed up quite frequently, which caused Talend to crash. The message poped up in all different jobs and elements. It seemed not to be triggered by a single job or action.
    * The solution is a mixture between the deactivation of the antivirus software "Avast" and changing the value for the Limit-field of the tFileInputDelimiter element at the beginning of the job.

    <img width="900" alt="DelimiterError" src="images/DelimiterError.png">

* Fetching just the newest order from the database
    * The issue with reading just the newest entry from the database was, that the SQL-Statement in Talend did not accept a WHERE-clause. With the keyword MAX() we could filter the ID-field after the newest entry, but the rest of the table would be another one.
    * The idea for the solution came through the great effort of our lecturer and Talend-specialist Maja Spahic. She had the idea to get the highest ID of all the orders with the tAggregateRow element, and connect it to the corresponding entries in the database through a tMap lookup.

    <img width="900" alt="Maxorder_lookup" src="images/Maxorder_lookup.png">

    * Then the newest order is written into a new database table "Maxorder" which concludes of just the newest entry always. To ensure this, the table is cleared before inserting the new data.

    <img width="900" alt="maxorder_db" src="images/maxorder_db.png">

* Sending Emails via Talend
    * We could not send emails via the tSendMail element. We tried a lot of different combinations of ports, providers, email adresses and configurations of the element. But nothing seemed to help.
    * In the end, the solution was rather simple. Again the antivirus software "Avast" seemed to block all ports for Talend. With a deactivation this could be managed.

* Using variables to display database values in a email text.
    * Another problem we faced was the use of variables in an tSendMail element to display values of the database like orderID or tracking number. At first, we tried to make the DB values useable through a tJavaRow element. After this did not work, we tried to hardcode the variables with a tJava element. But this did not work either.
    * To achieve this purpose, we used the ToIterate element from Talend. This elements allows us to use date from a connection to be further processed in a global variable.

    <img width="900" alt="sendmail_toiterate" src="images/sendmail_toiterate.png">

    * Depending on the datatype, this global variable can then be used with the following statement directly within the body of the email. In our case, the integer with the name order_id is read used as a global variable from the connection "row22". 

    <img width="900" alt="sendmail_body" src="images/sendmail_body.png">