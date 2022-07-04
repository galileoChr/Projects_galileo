<!-- logout.php -->
<!-- By Christophe Manzi -->

<!DOCTYPE html>


<?php 
session_start();
$loggedInAtStartOfLogout = isset($_SESSION['customer_id']) ? true : false;

if ($loggedInAtStartOfLogout)
{
  session_unset();
  session_destroy();
}

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
        <h4>Logout</h4>
        <?php
        if($loggedInAtStartOfLogout){
          echo 
          '<p>Thank you for visiting our e-store.<br>
          You have successfully logged out.</p>
          <p>If you do wish to log back in,
          <a href="pages/formLogin.php">click here</a>.</p>
          <p>To browse our product catalog
          <a href="pages/catalog.php">click here</a>.</p>';
        }
        else {
          echo
          '<p>Thank you for visiting Platinum-ish.
          You have not yet logged in.</p>
          <p>If you do wish to log in,
          <a href="pages/formLogin.php">click here</a>.</p>
          <p>Or you can browse our product catalog without logging in by
          <a href="pages/catalog.php">clicking here</a>.</p>';
        }
        ?>

    </article>
</main>

<?php 

//  <!-- footer.html -->
include '../common/footer.html';

?>

</html>