<?php
/*formLoginProcess.php
Processes the login form data and sets up the necessary
session data for the user to shop. If incorrect login 
information (bad username and/or bad password) is entered,
the user is redirected back to the login form. 
*/
session_start();
if (isset($_SESSION['customer_id'])){
    header("Location: ../pages/estore.php");
}
   

$_SESSION['POST_SAVE'] = $_POST;

include("connectToDatabase.php");

$query = "SELECT * FROM my_Customer
                   WHERE login_name = '$_POST[loginName]'";
$rowsWithMatchingLoginName = mysqli_query($db, $query);
$numRecords = mysqli_num_rows($rowsWithMatchingLoginName);
if ($numRecords == 0)
{
    //No records were retrieved, so ...
    header("Location: ../pages/formLogin.php?retrying=true");
}
if ($numRecords == 1)
{
    $row = mysqli_fetch_array($rowsWithMatchingLoginName, MYSQLI_ASSOC);
    if (md5($_POST['loginPassword']) == $row['login_password'])
    {
        $_SESSION['customer_id'] = $row['customer_id'];
        $_SESSION['salutation']  = $row['salutation'];
        $_SESSION['first_name'] = $row['first_name'];
        $_SESSION['middle_initial'] = $row['middle_initial'];
        $_SESSION['last_name'] = $row['last_name'];
        $previousPage = getenv('HTTP_REFERER');
        header("Location: ".$previousPage);
        
        // $productID = $_SESSION['purchasePending'];
        // if ($productID != "")
        // {
        //     unset($_SESSION['purchasePending']);
        //     $destination =
        //         "../pages/shoppingCart.php?productID=$productID";
        //     $goto  = "Location: $destination";
        // }
        // else
        // {
        //     $destination = getenv('HTTP_REFERER'); 
        //     $goto  = "Location: ".$destination;
        // }
        // header($goto);
    }
    else
    {
        //The password entered did not match the database
        //password for the login name entered, so ...
        header("Location: ../pages/formLogin.php?retrying=true");
    }
}
mysqli_close($db);
?>
