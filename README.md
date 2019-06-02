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
 

## Implemnetation
### Order Service
1.	The first implementation was the input of the order over the smart speaker. To simulate this, we use Dialogue Flow. In Dialogue Flow we created various intents such as Welcome and Goodbye to contain training word that the machinea can recognize. We also created one that contained training phrases which would occur in our scenario (see picture).

<img width="500" alt="Dialogue Flow" src="images/DialogueFlow.PNG">

For the order entred in the Dialogue Flow to be processed we linked it to the Integromat. In the Integromat we created a webhook that connected to the Dialogue Flow. Through the webhook the integromat would take the order data. The data would then be entered into a Google sheets and at the same time an email would be sent to the customer containing the entered data.

<img width="500"  alt="Integromat" src="images/Integromat.PNG">


<img width="500" alt="Google Sheet" src="images/GoogleTableOrder_Listener.PNG">

Talend then downloads the Google file from the internet so as to access the data within. To start the purchasing process, the data from the order is extracted from the file and input into the database. The database created beforehand contains three tables: Customer, Product and Order. 
From there a service is used to take the price of the products ordered from the database; this is done through using an XMLMap. This output is then used to calculate the sum by multiplying the ordered quantity by the according price. This sum is then put into the Order table in the database.  

### Payment Service
The next step is to deduct the outstanding amount from the customers pre-existing balance. The customer’s balance is then updated in the Customer table of the database.

### Inventory Service
Before completing the purchase, it then checks the stock of the ordered products from the Product table in the database. The ordered quantity is then subtracted from the existing inventory. If, however, there is not enough inventory for the product, it loads 100 more units to the product’s inventory. 

### Shipment Service
The values are imported into the Shipping table of the database, which has the java row defined as the variable. An email is then sent to the customer with an order confirmation, stating the order has been shipped, and provides the customer with the tracking number of the order.

### Issues
-Antivirus causes talend to crash
-File delimiter a limit has sometimes to be changed due to the same error message as from Antivirus
-Maxorder table due to issue with tmap and lookups