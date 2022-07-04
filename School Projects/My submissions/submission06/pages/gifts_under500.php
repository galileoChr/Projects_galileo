<!-- gifts_under500.php -->
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
        <h3>Gifts under $500</h3>
        <p>
        Here are some typical kinds of gifts that you can get under $500:
        </p>
        <ul>
        <li>Poppy Finch Cultured Pearl Linear Drop Earrings at $395</li>
        <li>Lana Jewelry 'Large Upside Down' Hoop Earrings at $495</li>
        <li>Anzie Boheme Bracelet at $372.00</li>
        </ul>
      </article>
    </main>

<?php 

//  <!-- footer.html -->
include '../common/footer.html';

?>

</html>



