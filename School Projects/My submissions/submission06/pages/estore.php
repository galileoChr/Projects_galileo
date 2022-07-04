<!-- estore.php -->
<!-- By Christophe Manzi -->
<!DOCTYPE html>

<?php 
   session_start();
   $loggedIn = isset($_SESSION['customer_id']) ? true : false;
   // <!-- document_head.html -->
   include '../common/document_head.html';

  // <!-- banner.html -->
  include '../common/banner.php';

  // <!-- menus.html -->
  include '../common/menus.html'; 
 ?>

<!-- main -->

<main class="w3-container">
    <article class="w3-container w3-border-left w3-border-right
                     w3-border-black w3-light-grey">
        <h3>Welcome to our e-store ... thanks for visiting.</h3>
        <p>
            We carry a large collection of truly unique products. For
            your shopping and browsing convenience, please choose one
            of the following links:
        </p>
        <ul>
            <li>
                To browse our exciting product catalog
                <a href="pages/catalog.php">click here</a>.
            </li>
            <?php
            if($loggedIn){
                echo 
                '<li>
                Trying to log in as a different user?<br>
                You must first <a 
                href="pages/logout.php">click here to log out</a>.';
            } else {
                echo 
                '<li>
                Ready to purchase and already have a username and password?
                <br>To log in to our e-store and begin shopping
                <a href="pages/formLogin.php">click here</a>.
            </li>
            <li>
                Need to register for our e-store so you can make purchases?
                <br>To register (you only need to do it once)
                <a href="pages/formRegistration.php">click here</a>.
            </li>
            <li>
                Trying to log in as a different user?<br>You must first
                <a href="pages/logout.php">click here to log out</a>.
            </li>';
            }
            ?>
            
        </ul>
    </article>
</main>

<?php 

//  <!-- footer.html -->
include '../common/footer.html';

?>

</html>