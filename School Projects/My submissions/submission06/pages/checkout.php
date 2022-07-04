<?php
/*checkout.php
This page handles the user's checkout process at the highest-level,
if that user has come here from his or her shopping cart, and
otherwise the user is redirected to a view of the current status
of the user's shopping cart.
*/
session_start();
if (!preg_match('/shoppingCart.php/', $_SERVER['HTTP_REFERER']))
    header("Location: shoppingCart.php?productID=view");
$customerID = $_SESSION['customer_id'];

 // <!-- document_head.html -->
 include '../common/document_head.html';

 // <!-- banner.html -->
 include '../common/banner.php';

 // <!-- menus.html -->
 include '../common/menus.html'; 
 
 // <!-- connectToDatabase.php -->
 include '../scripts/connectToDatabase.php'; 
?>


<main class="w3-container">
      <article class="w3-container w3-border-left w3-border-right
                     w3-border-black w3-light-grey">
        <?php
        include("../scripts/checkoutProcess.php");
        ?>
    </article>
</main>

<?php 

//  <!-- footer.html -->
include '../common/footer.html';

?>

</html>