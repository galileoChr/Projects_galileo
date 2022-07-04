<!-- formRegistrationResponse.php -->
<!-- By Christophe Manzi -->
<!DOCTYPE html>


<?php 
   // <!-- document_head.html -->
   include '../common/document_head.html';

  // <!-- banner.html -->
  include '../common/banner.php';

  // <!-- menus.html -->
  include '../common/menus.html'; 

  include '../scripts/connectToDatabase.php';
 ?>

<!-- main -->
<!-- <main> -->
    <!-- <article class="w3-container w3-border-left w3-border-right
                     w3-border-black w3-light-grey"> -->
    <!-- <div class="w3-container w3-border-left w3-border-right
                 w3-border-black w3-light-grey"> -->
    
    <!-- </div> -->
    <!-- </article> -->
<!-- </main> -->
<main class="w3-container">
    <div class="w3-container w3-border-left w3-border-right
                 w3-border-black w3-light-grey">
        <?php
        include("../scripts/formRegistrationProcess.php");
        ?>
    </div>
</main>
<?php 

//  <!-- footer.html -->
include '../common/footer.html';

?>


</html>