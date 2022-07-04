<?php
/*shoppingCartAddItem.php
Adds an item to the user's shopping cart, and redisplays the cart.
*/
session_start();
include("connectToDatabase.php");

//========== main script begins here
$customerID = $_SESSION['customer_id'];
$productID = $_GET['productID'];

//Get the order ID for the current order in progress
$query =
    "SELECT
        my_Order.order_id,
        my_Order.order_status,
        my_Order.customer_id
    FROM my_Order
    WHERE
        my_Order.order_status = 'IP' and
        my_Order.customer_id = $customerID";
$order = mysqli_query($db, $query);    
$row = mysqli_fetch_array($order, MYSQLI_ASSOC);
$orderID = $row['order_id'];

//Get the quantity in inventory of the requested product
$query =
    "SELECT *
    FROM my_Product
    WHERE product_id = '$productID'";
$product = mysqli_query($db, $query);
$row = mysqli_fetch_array($product, MYSQLI_ASSOC);
$productQuantity = $row['quantity'];
$productName = $row['name']; 

$quantityRequested = $_GET['quantity'];
if ($quantityRequested == 0 or $quantityRequested > $productQuantity)
{
   echo "This part is not working";
    $gotoRetry = "../pages/shoppingCart.php?
                  productID=$productID&retryingQuantity=true";
    header("Location: $gotoRetry");
}
else
{
   
    $productPrice = $row['price'];
    $query = "INSERT INTO my_OrderItem
    (
        order_item_name,
        order_item_status,
        order_id,
        product_id,
        quantity,
        price
    )
    VALUES
    (
        '$productName',
        'IP',
        '$orderID',
        '$productID',
        '$quantityRequested',
        '$productPrice'
    )";
    $success = mysqli_query($db, $query);
    if(!$success)
    {
        echo "Error: INSERT failure in shoppingCartAddItem.";
        echo mysqli_error($db);
        exit(0);
    }
    header("Location: ../pages/shoppingCart.php?productID=view");
}
//========== main script ends here
?>