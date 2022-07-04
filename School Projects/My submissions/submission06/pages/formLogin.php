<!-- formLogin.php -->
<!-- By Christophe Manzi -->

<!DOCTYPE html>


<?php 
 session_start();
 if (isset($_SESSION['customer_id'])) {
    header('Location: estore.php');
 }

 $retrying = isset($_GET['retrying']) ? true : false;

  // <!-- document_head.html -->
  include '../common/document_head.html';
   // <!-- banner.html -->
   include '../common/banner.php';

   // <!-- menus.html -->
   include '../common/menus.html'; 
?>


<?php
$loginNameSaved = isset($_SESSION['POST_SAVE']["loginName"]) ?
                        $_SESSION['POST_SAVE']["loginName"] : "";
$loginPasswordSaved = isset($_SESSION['POST_SAVE']["loginPassword"]) ?
                            $_SESSION['POST_SAVE']["loginPassword"] : "";

?>
<!-- main -->
<main class="w3-container">
    <article class="w3-container w3-border-left w3-border-right
                     w3-border-black w3-light-grey">
        <h4 class="w3-center"><strong>Login Form</strong></h4>

        <p class="w3-center w3-red w3-padding">Important Note</p>

        <p><span class="w3-padding-16">Purchasing items from our on-line
                e-store requires logging in. And if you have not yet registered with
                Platinum-ish, before attempting to log in you must
                <a href="pages/formRegistration.php">register here</a>.</span></p>

        <form id="loginForm" action="scripts/formLoginProcess.php" method="post" autocomplete="on">
            <div class="w3-row w3-section">
                <div class="w3-quarter w3-container">
                    Login Name:
                </div>
                <div class="w3-threequarter w3-container w3-wide">
                    <input type="text" name="loginName" required style="width: 90%;"
                        placeholder="Must be name assigned at registration" value="<?php echo $loginNameSaved; ?>">
                </div>
            </div>
            <div class="w3-row">
                <div class="w3-quarter w3-container">
                    Password:
                </div>
                <div class="w3-threequarter w3-container w3-wide">
                    <input type="password" name="loginPassword" required style="width: 90%;"
                        placeholder="Must be password chosen at registration"
                        value="<?php echo $loginPasswordSaved; ?>">
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-quarter w3-container">
                    &nbsp;
                </div>
                <div class="w3-threequarter w3-container">
                    <input type="submit" value="Log in">
                    <input type="reset" value="Reset Form" onclick="this.form.reset()">
                </div>
            </div>

            <div class="w3-row">
                <?php 
                     if($retrying) { ?>
                <p class="w3-red w3-padding">
                    Sorry, but your login procedure failed.
                    An invalid username or password was entered.
                    Please try again to enter your correct login information.
                </p>
                <?php
                     }
                    ?>
            </div>

        </form>
    </article>
</main>

<?php 

//  <!-- footer.html -->
include '../common/footer.html';

?>

</html>