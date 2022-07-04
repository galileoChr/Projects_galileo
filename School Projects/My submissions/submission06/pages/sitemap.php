<!-- sitemap.php -->
<!-- By Christophe Manzi -->

<!DOCTYPE html>


<?php 
  session_start();
  // <!-- document_head.html -->
  include '../common/document_head.html';

  // <!-- banner.html -->
  include '../common/banner.php';

  // <!-- menus.html -->
  include '../common/menus.html'; 

 ?>
  <!-- main -->
<main class="w3-container">
      <div class="w3-container w3-border-left w3-border-right
                  w3-border-black w3-light-grey">
      <div class="w3-half w3-border w3-border-black">
        <ul class="w3-ul">
          <li><h4 class="w3-wide"><a href="my_business.php">Home</a></h4></li>
        </ul>
        <ul class="w3-ul w3-border-top w3-border-black">
          <li><h4 class="w3-wide">e-store</h4></li>
          <li><a href="pages/estore.php">e-store Options</a></li>
          <li><a href="pages/catalog.php">Product Catalog</a></li>
          <li><a href="pages/formRegistration.php">Register</a></li>
          <li><a href="pages/formLogin.php">Login</a></li>
          <li><a href="pages/shoppingCart.php?productID=view">View Shopping Cart</a></li>
          <li><a href="pages/checkout.php">Checkout</a></li>
          <li><a href="pages/logout.php">Logout</a></li>
        </ul>
      </div>
      <div class="w3-half w3-border w3-border-black">
        <ul class="w3-ul">
          <li><h4 class="w3-wide">Gifts</h4></li>
          <li><a href="pages/gifts_under150.php">Gifts under $150</a></li>
          <li><a href="pages/gifts_under300.php">Gifts under $300</a></li>
          <li><a href="pages/gifts_under500.php">Gifts under $500</a></li>
        </ul>
        <ul class="w3-ul w3-border-top w3-border-black">
          <li><h4 class="w3-wide">About Us</h4></li>
          <li><a href="pages/vision.php">Vision and Mission</a></li>
          <li><a href="pages/locations.php">Locations</a></li>
          <li><a href="pages/formFeedback.php">Tell Us What You Think</a></li>
        </ul>
        <ul class="w3-ul w3-border-top w3-border-black">
          <li>
            <h4 class="w3-wide">
              <a href="pages/sitemap.php">Site Map</a>
            </h4>
          </li>
        </ul>
      </div>
      </div>
    </main>

<?php 

//  <!-- footer.html -->
include '../common/footer.html';

?>

</html>