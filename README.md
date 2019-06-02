# Säntis Group

## Introduction
The Santis group is a grocery store that ships it's products to their customers' front door. Santis' customers put in their order over their smart speaker. Once the clients have placed their order, they receive a confirmation email that it is being processed. The income of the order triggres the process of charging the customers credit card. Once the order is fulfilled they receive another email informing them that their package is on its way and a tracking number.

## Scenario
We took the scenario suggested by the lectures and adopted it into Santis process. We divided the process into four main process steps which are order placement, receive payment, update inventory and shipping the order. In our integration scenario each process step is executed by a service.

<img withd="647" alt="Structure" src="images/ServiceStructure.png">

1. The process starts when the customer makes their order. To place it, they will use their smart speaker such as Alexa or Google Home.
2. Once their speaker takes and executes the customer's order they will receive a confirmation e-mail. In the back ground the order will be saved to a Table on Google Drive to be then access and processed later.
3. Talend will be executing the next steps of the order management process.
4. In the order placement step, the order service will read the Google Excel sheet and extract from there the content of the order. It then enters the information into the Database. Once it stores the data, it triggers the next step.
5. We chose to state that the payement must be made before the inventory can be altered. The fulfil the receive payment step, the payment service first has to calculate the sum of the order. Then it must make sure that the clients credit card has sufficient cash on it to pay for the products. If that is the case if deuces the calculated amount from the credit card and triggers the next step.
6. The inventory job checks if the items ordered are in stock. If that is the case it will reduce the stock by the ordered amount. 
7. The shipping job creates a tracking number for the order and then sends an email to the customer. And completes the process by shipping the order to the customer.

 

## Execution of each servies
### Order Service
1.	The first implementation was the input of the order over the smart speaker. To simulate this, we use Dialogue Flow. In Dialogue Flow we created various intents such as Welcome and Goodbye to contain training word that the machinea can recognize. We also created one that contained training phrases which would occur in our scenario (see picture).

<img withd="200" alt="Dialogue Flow" src="images/DialogueFlow.png">

For the order entred in the Dialogue Flow to be processed we linked it to the Integromat. In the integromat we created a webhook that connected to the Dialogue Flow. Through the webhook the integromat would take the order data. The data would then be entered into a google sheets and at the same time an email would be sent to the customer containing the entered data.

<img alt="Integromat" src="images/Integromat.png">

image of excel sheet
<img alt="Google Sheet" src="images/GoogleTableOrder_Listener.png">

Talend then downloads the google file from the internet so as to access the data within. To start the purchasing process, the data from the order is extracted from the file and input into the database. The database created beforehand contains three tables: Customer, Product and Order. 
From there a service is used to take the price of the products ordered from the database; this is done through using an XMLMap. This output is then used to calculate the sum by multiplying the ordered quantity by the according price. This sum is then put into the Order table in the database.  

### Payment Service
The next step is to deduct the outstanding amount from the customers pre-existing balance. The customer’s balance is then updated in the Customer table of the database.

### Inventory Service
Before completing the purchase, it then checks the stock of the ordered products from the Product table in the database. The ordered quantity is then subtracted from the existing inventory. If, however, there is not enough inventory for the product, it loads 100 more units to the product’s inventory. 

### Shipment Service
The values are imported into the Shipping table of the database, which has the java row defined as the variable. An email is then sent to the customer with an order confirmation, stating the order has been shipped, and provides the customer with the tracking number of the order.