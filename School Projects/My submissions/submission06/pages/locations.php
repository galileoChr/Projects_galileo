<!-- locations.php -->
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
      <h3>Our Locations</h3>
      <p>
        As our company grows, we hope to expand world wide, so
        eventually we will provide here a list of all our store
        locations. Each location will be accompanied by contact
        information for that location and a link to a map showing
        showing you how to find us at that location.
      </p>
      <p>
        In the meantime, here are a few details (just address
        and telephone number) for our current (and only) location,
        should you wish to drop by:
      </p>
      <p>
        Platinum-ish, Inc.<br>
        4040 Main Street<br>
        Halifax, NS<br>
        Canada B3H 8X8<br>
        Tel: 902.142.1234
      </p>
    </article>
  </main>

  <?php 

//  <!-- footer.html -->
include '../common/footer.html';

?>


</html>