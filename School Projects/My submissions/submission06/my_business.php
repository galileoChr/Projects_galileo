<!-- my_business.php for Platinum-ish, version 6 -->
<!-- By Christophe Manzi -->

<!DOCTYPE html>

<?php 
session_start();
   // <!-- document_head.html -->
   include 'common/document_head.html';

   // <!-- banner.html -->
   include 'common/banner.php';

   // <!-- menus.html -->
   include 'common/menus.html';
    
 ?>

<!-- main -->
<main class="w3-container">
    <div class="w3-container w3-border-left w3-border-right
                   w3-border-black w3-light-grey" style="padding-right:0">
        <article class="w3-half">
            <h3>
                You've come to Platinum-ish!
            </h3>
            <p>
                Founded in 2020, Platinum-ish was created to sell high-end 
                products
                like rings, watches, necklaces and more luxurious jewellery. 
                Our merchandise
                is a selection for the very best in unique, handmade pieces 
                from popular
                brands.
            </p>
            <p>
                If you like to explore custom made products, you've
                come to the right place ... check out our e-store!
            </p>
        </article>

        <?php
    include 'resources/images_and_labels.html';
    ?>
    </div>
</main>


<?php 
//  <!-- footer.html -->
 include 'common/footer.html';
 ?>

</html>