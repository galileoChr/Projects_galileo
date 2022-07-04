<!-- shoppingCart.php -->
<!-- By Christophe Manzi -->

<!DOCTYPE html>
<?php 
/*shoppingCart.php
This page provides the "high-level" shopping cart view, if in
fact the visitor has a shopping cart. Otherwise the visitor is
redirected to the login page.
*/
session_start();
// <!-- connectToDatabase.php -->
include '../scripts/connectToDatabase.php'; 

$customerID = isset($_SESSION['customer_id']) ? $_SESSION['customer_id'] : "";
$productID = $_GET['productID'];

if ($customerID == "")
{
    $_SESSION['purchasePending'] = $productID;
    header("Location: formLogin.php");
}

   // <!-- document_head.html -->
   include '../common/document_head.html';

  // <!-- banner.html -->
  include '../common/banner.php';

  // <!-- menus.html -->
  include '../common/menus.html'; 
  
  
 ?>

<main class="w3-container">
      <article class="w3-container w3-border-left w3-border-right
                     w3-border-black w3-light-grey">
        <h4 class="w3-center">
          <strong>Your Shopping Cart</strong>
        </h4>
        <?php
        include("../scripts/shoppingCartProcess.php");
        ?>
      </article>
  </main>

<?php 

//  <!-- footer.html -->
include '../common/footer.html';

?>


</html>