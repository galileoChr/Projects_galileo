<!-- sorry.php -->
<!-- By Christophe Manzi -->

<!DOCTYPE html>

<?php 
session_start();
   // <!-- document_head.html -->
   include '../common/document_head.html';

   // <!-- banner.html -->
 include '../common/banner.php';

//  <!-- menus.html -->
 include '../common/menus.html';
 ?>

 <!-- main -->
 <main class="w3-container">
      <div class="w3-container w3-border-left w3-border-right
                 w3-border-black w3-light-grey">
        <h1 class="w3-margin w3-center">
          Sorry!
        </h1>
        <h2 class="w3-margin w3-center">
          This page has not yet been activated,<br>
          or has been temporarily deactivated.
        </h2>
      </div>
    </main> 
      
  <?php 
   //  <!-- footer.html -->
 include '../common/footer.html';
 
 ?>
</html>
