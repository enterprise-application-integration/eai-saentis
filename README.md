# Säntis Group

## Introduction
The Santis group is a grocery store that ships it's products to their customers' front door. Santis' customer has the option to make their order over their smart speaker. Once their order is placed, they receive a confirmation email that their order is being processed. Meanwhile their credit card is charged with their purchase and once the order is fulfilled they receive another email informing them that their package is on its way and a tracking number.

## Scenario
We took the scenario suggested by the lectures and adopted it into Santis process. We divided the process into four main process steps which are order placement, receive payment, update inventory and ship the order. In our integration scenario each process step is executed by a service.

<img withd="647" alt="Structure" src="images/ServiceStructure.png">

1. The process starts when the customer makes their order. To place the order they will use their smart speaker such as Alexa or Google Home.
2. Once their speaker takes the customer order they will receive a confirmation e-mail. In the back ground the order will be save to a Table on Google Drive to be then access and processed later.
3. Talend will be executing the next steps of the order management process.
4. In the order placement step, the order service will read the Google Excel sheet and extract from there the content of the order. It then enters the information into the Database. Once it stores the data, it triggers the next step.
5. We chose to state that the payement must be made before the inventory can be altered. The fulfil the receive payment step, the payment service first has to calculate the sum of the order. Then it must make sure that the clients credit card has sufficient cash on it to pay for the products. If that is the case if deuces the calculated amount from the credit card and triggers the next step.
6. The inventory job checks if the items ordered are in stock. If that is the case it will reduce the stock by the ordered amount. 
7. The shipping job creates a tracking number for the order and then sends an email to the customer. And completes the process by shipping the order to the customer.

 

## Execution of each servies
### Order Service
(image dialogue flow)
<img alt="Dialogue Flow" src="images/DialogueFlow.png">
(image of integromat)
<img alt="Integromat" src="images/Integromat.png">
image of excel sheet
<img alt="Google Sheet" src="images/GoogleTableOrder_Listener.png">

image of taled process

### Payment Service


### Inventory Service


### Shipment Service


1. In our scenario the customer places their order throught their google home.  Through the intergromat the dialague flow message is processed and enterd into a exael sheet on google docs.
2.The customer receives a confimation e-mail listing the content of their order.
3.
4.
5.