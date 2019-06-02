# Säntis Group

## Introduction
The Santis group is a grocery store that ships it's products to their customers' front door. Santis' customers put in their order over their smart speaker. The income of the order triggres the process of charging the customers credit card. Once the order is fulfilled they receive an email informing them that their package is on its way also including a tracking number for them to trace their packet.

## Scenario
We took the scenario suggested by the lectures and adopted it into Säntis process. As it was suggested the process can be split into four main process steps: order placement, receive payment, update inventory and order shipment.

<img width="500" alt="Structure" src="images/ServiceStructure.png">

1. The order placement starts when the customer makes their order. To place it, they will use their smart speaker such as Alexa or Google Home.
2. Once the speaker takes and executes the order, it will be saved to a Table on Google Drive to later be access and processed.
3. The order payment starts with the reading of the order from the Google Excel sheet and inserted into the database. 
4. As a next step the price of the articles order will be read from the product table. Then the order amount is taken and multiplied by the price to result in the order sum.
5. The order sum it then subtracted from the clients credit card.
6. The next step of updating the inventory is done by reading the order amount and updating it in the product table of the database.
7. Lastly, the order shipment requires the generation of a tracking number which is then sent in an email to the customer, confirming the shipping of the order.

## Implementation
We designed the process as a choreography. Meaning that the sub-processes would we link among each other and not be delegated by a central brain. We chose to implement it this way because the order of the process steps was not going to change throughout this project. Additionally implementing a process as a choreography brings the drawback of it being difficult to manage and maintain, this does not apply to our project since be do not plan on modifying it after completing the project. As to the disadvantage of it being difficult to monitor and track errors, we were able to side step this because our project was small in size and complexity. Based on the way we implemented the process the steps are of a synchronous nature, meaning that each process step has to be successfully complete for it to pass on to the next step. 

### Database
To implement the scenario we created a database for the project. The database has 5 tables: customer, product, orders, shipping and maxorder. The customer table contains the common attributes such as Name and address but also the customers credit card number and balance. The product table holds the list of products with their prices and the amount on stock. The orders table and maxorder both hold the same attributes such ad customer and order ID, product name and quantity as well as the order sum. The difference between these to is that the order table holds all order made and entered into the database where as maxorder only contains the most current order that is being processed. Lastly the shipping table holds the tracking number of the shipment but only not newest order.

### Order placement
The first implementation we did was the input of the order over the smart speaker. To simulate this, we use Dialogue Flow. In Dialogue Flow we created various intents such as Welcome and Goodbye to contain training word that the machine can recognize. We also created one that contained training phrases which would occur in our scenario (see picture).

<img width="500" alt="Dialogue Flow" src="images/DialogueFlow.PNG">

For the order entered in the Dialogue Flow to be processed we linked it to the Integromat. In the Integromat we created a webhook and linked it to the Dialogue Flow. Through the webhook the order data will be taken and enter it into a Google sheet.

<img width="500"  alt="Integromat" src="images/Integromat.PNG">

The order data in the google sheet called Order_Listener will always be overwritten with the newest order.

<img width="500" alt="Google Sheet" src="images/GoogleTableOrder_Listener.PNG">

To start the order placement, the  Google sheet has to be read by Talend. To do so the file has to be published to the Web. Then through the tFileFetch component it can be retrieve using the files URL link. IF the file is fetched successfully the next part of the job is triggered.
The next job is for the data from the order to be extracted from the file and inputted into the orders table, which located in the database.
The task of the next sub-job is for the newest line of the order table to be read and inputted into the maxorder. For the last order made to be read the tAggregateRow component is used. It goes through the order_id column and looks for the largest number. The newest order is then entered into the maxorder table at the same time overwriting the existing row in that table.

<img width="500" alt="Order Placement" src="images/TalendOrderPlacement.PNG">


### Payment Service

The next step is to deduct the outstanding amount from the customers pre-existing balance. The customer’s balance is then updated in the Customer table of the database.

<img width="500" alt="Calculate Price" src="images/TalendPriceCalculation.PNG">

<img width="500" alt="Service Finance" src="images/TalendServiceFinance.PNG">

<img width="500" alt="Receive Payment" src="images/TalendReceivePayment.PNG">

### Inventory Service

Before completing the purchase, it then checks the stock of the ordered products from the Product table in the database. The ordered quantity is then subtracted from the existing inventory. If, however, there is not enough inventory for the product, it loads 100 more units to the product’s inventory.

 <img width="500" alt="Inventroy Update" src="images/TalendUpdateInventory.PNG">

### Order Shipment
The last step is the order shipment. This step requires the generation of a shipment ID for the customer’s order. The number is autogenerated when the order ID from maxorder table is entered into the shipping table. On the successful execution of that sub-job the shipment ID is read from the database. It is then embedded into an e-mail that is sent to the customer to inform them that their order in on its way.

<img width="500" alt="Order Shipment" src="images/TalendOrderShipment.PNG">

<img width="500" alt="Shipment Email" src="images/ShipmentEmail.PNG">

### Issues
Issues we have encounter during our project were:
-Antivirus causes talend to crash
-File delimiter a limit has sometimes to be changed due to the same error message as from Antivirus
-Maxorder table due to issue with tmap and lookups