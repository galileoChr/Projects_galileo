<!-- catalog.php -->
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

  // <!-- connectToDatabase.php -->
  include '../scripts/connectToDatabase.php'; 

 ?>

<!-- main -->
<main class="w3-container">
    <article class="w3-container w3-border-left w3-border-right
                     w3-border-black w3-light-grey">
        <h4>
            Items Available in Your Chosen Category&nbsp;&nbsp;&nbsp;&nbsp;
            <a class='w3-button w3-green w3-round w3-small' 
               href='pages/catalog.php'>
                Return to category list
            </a>
        </h4>
        <?php
        include '../scripts/categoryProcess.php';
        ?>

    </article>
</main>


<?php 

//  <!-- footer.html -->
include '../common/footer.html';

?>

</html>