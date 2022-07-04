<?php
/*shoppingCartProcess.php
Handles interaction between the user and the database
for Shopping Cart transactions.
Included by pages/shoppingCart.php.
Calls these functions (defined below):
getExistingOrder()
createOrder()
displayHeader()
displayExistingItemColumns()
displayNewItemColumns()
displayFooter()
*/
//========== main script begins here
$retrying = isset($_GET['retrying']) ? true : false;
$items = getExistingOrder($db, $customerID);
$numRecords = mysqli_num_rows($items);

if ($numRecords == 0 && $productID == 'view')
{
    echo
  
    "<h4 class='w3-center'>Your shopping cart is empty.</h4>
    <h4 class='w3-center'>To continue shopping, please
    <a  href='pages/catalog.php'>click here</a>.</h4>
    ";
}
else
{
    displayHeader();
    $grandTotal = 0;
    if ($numRecords == 0) //Shopping cart is empty
    {
        createOrder($db, $customerID);
    }
    else //Shopping cart contains one or more items to display
    {
        for ($i=1; $i<=$numRecords; $i++)
        {
            $grandTotal += displayExistingItemColumns($db, $items);
        }
    }
    
    if ($productID != 'view') //Display entry row for new item
    {
      echo "productID not view";
        if ($retrying)
        {
            echo
            "<tr>
              <td class='w3-center' colspan='7'>Please re-enter a
                product quantity not exceeding the inventory level.
              </td>
             </tr>";
        } 
        displayNewItemColumns($db, $productID);
    }
    displayFooter($grandTotal);
}
mysqli_close($db);
//========== main script ends here


/*getExistingOrder()
Retrieves from the database the items in an existing order,
that is, items currently in the shopping cart that have not
been purchased by going through checkout.
*/
function getExistingOrder($db, $customerID)
{
    $query =
        "SELECT
            my_Order.order_id,
            my_Order.customer_id,
            my_Order.order_status,
            my_OrderItem.*
        FROM
            my_OrderItem, my_Order
        WHERE
            my_Order.order_id = my_OrderItem.order_id and
            my_Order.order_status = 'IP'        and
            my_Order.customer_id = $customerID";
    $items = mysqli_query($db, $query);
    return $items;
}

/*createOrder()
Creates a new order, to which items may be added for purchase.
*/
function createOrder($db, $customerID)
{
    $query = "INSERT INTO my_Order
    (
        customer_id,
        order_status,
        date_time    
    )
    VALUES
    (
        '$customerID',
        'IP',
        SYSDATE()
        
    )";
    $success = mysqli_query($db, $query);
    if(!$success)
    {
      echo "Error: INSERT failure in createOrder.";
      exit(0);
    }
}

/*displayHeader()
Displays headers for the seven columns of the shopping cart table.
*/
function displayHeader()
{
    echo 
    "<form id='orderForm'
           action='scripts/shoppingCartAddItem.php'>
      <table class='w3-table w3-border w3-bordered'>
        <tr>
          <th>Product Image</th>
          <th>Product Name</th>
          <th>Price</th>
          <th># in Stock</th>
          <th>Quantity</th>
          <th class='w3-right'>Total</th>
          <th class='w3-center'>Action</th>
        </tr>";
}

/*displayFirstFourColumns()
Displays the first four columns of a row of the shopping cart
table. The contents of the last three columns of a row of the
table will be different, depending on whether the row contains
information for an item that's already in the shopping cart,
or an item that has been chosen for adding to the cart but is
not yet in it.
*/
function displayFirstFourColumns($db, $productID)
{
    $query =
      "SELECT *
      FROM my_Product
      WHERE product_id='$productID'";
    $product = mysqli_query($db, $query);
    $row = mysqli_fetch_array($product, MYSQLI_ASSOC);
    $productPrice = sprintf("$%1.2f", $row['price']);
    $productImageFile = $row['image_file'];
    echo
    "<tr>
      <td class = 'w3-center'>
        <img width='70'
             src='images/products/$productImageFile' 
             alt='Product Image'>
      </td><td class='w3-center'>
        $row[name]
      </td><td class='w3-right-align'>
        $productPrice
      </td><td class='w3-center'>
        $row[quantity]
      </td>";
}

/*displayExistingItemColumns()
Displays the last three columns of information for an item that
is alreay in the shopping cart. This information includes the
quantity ordered, the total price, and buttons to allow the
deletion of the item or continuing to shop by transferring
back to the product catalog. 
*/
function displayExistingItemColumns($db, $items)
{
    $row = mysqli_fetch_array($items, MYSQLI_ASSOC);
    $productID = $row['product_id'];
    displayFirstFourColumns($db, $productID);
    
    $total = $row['quantity'] * $row['price'];
    $totalAsString = sprintf("$%1.2f", $total);
    echo
      "<td>
        $row[quantity]
       </td><td class='w3-right-align'>
        $totalAsString
       </td><td class='w3-center'>
        <a class='w3-button w3-green w3-round w3-small'
            style='margin-bottom: 3px'
            href='scripts/shoppingCartDeleteItem.php?
            orderItemID=$row[order_item_id]&
            orderID=$row[order_id]'>
            Delete from cart</a>
        <a class='w3-button w3-green w3-round w3-small'
           href='pages/catalog.php'>
            Continue shopping
            </a>
        </td>
      </tr>";
    return $total;
}

/*displayNewItemColumns()
Displays the last three columns of information for an new item
that has been chosen for purchase but has not yet been added to
the shopping cart. This information includes a box for entering
the quantity desired, TBA in the total price spot, and buttons
to allow the addition of the item to the shopping cart or just
continuing to shop by transferring back to the product catalog,
thereby ignoring the given item. 
*/
function displayNewItemColumns($db, $productID)
{
    displayFirstFourColumns($db, $productID);
    echo
    "<td class='w3-center'>
      <input type='hidden' id='productID' name='productID' value=$productID>
      <input type='text' id='quantity' name='quantity' size='3'
             title='Enter number not exceeding number in stock'
             pattern='[1-9][0-9]?'>
     </td><td class='w3-right-align'>
      TBA
     </td><td class='w3-center'>
        <input class='w3-button w3-green w3-round w3-small' 
        style='margin-bottom: 3px'
        type='submit' value='Add to cart'>
        <a class='w3-button w3-green w3-round w3-small' 
        href='pages/catalog.php'>
        Continue shopping
        </a>
     </td>
  </tr>";
}

/*displayFooter()
Displays the final row of the shopping cart table, including
the grand total cost of items to be purchased and button to
permit proceeding to checkout.
*/
function displayFooter($grandTotal)
{
    $grandTotalAsString = sprintf("$%1.2f", $grandTotal);
    echo
    "<tr>
      <td class='w3-center' colspan='5'>
        <strong>Grand Total</strong>
      </td><td class='RightAligned'>
        <strong>$grandTotalAsString</strong>
      </td><td class='w3-center'>
        <a class='w3-button w3-green w3-round w3-small'
           href='pages/checkout.php'>
            Proceed to<br>checkout
            </a>
      </td>
    </tr>
  </table>
</form>";
}
?>
