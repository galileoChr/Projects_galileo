<!-- gifts_under300.php -->
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
      <article class="w3-container w3-border-left w3-border-right
                     w3-border-black w3-light-grey">
        <h3>Gifts under $300</h3>
        <p>
          Here are some typical kinds of gifts that you can get under $300:
        </p>
        <ul>
        <li>10K WHITE GOLD DIAMOND CHANNEL SET WEDDING BAND AT $299</li>
        <li>DIAMOND SEA OF LIFE DOLPHINE PENDANT 1/8 CT TW IN STERLING SILVER AT $172</li>
        <li>SAPPHIRE HEART NECKLACE AT $189.99</li>
        </ul>
      </article>
    </main>

<?php 

//  <!-- footer.html -->
include '../common/footer.html';

?>

</html>


