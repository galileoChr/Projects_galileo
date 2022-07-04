 <!-- formFeedbackProcess.php -->
<!-- By Christophe Manzi -->
<?php

session_start();
$secure = $_SESSION['SECURE'];
if($secure != "!@#$^%FDSSFDWQR@"){
    die('SECURE test failed.');
}
// if file location changes, modify the $origin url.
$origin = $_SESSION['ORIGIN'];
if($origin != "/~u23/submissions/submission06/pages/formFeedback.php"){
    die('SECURE test failed.');
}

$salutation = $firstName = $lastName = "";
$email = $phoneNumber = "";
$email = $message = "";

if($_SERVER["REQUEST_METHOD"] == "POST")
{
    $salutation = sanitized_input($_POST["salutation"]);
    $firstName = sanitized_input($_POST["firstName"]);

    if(!preg_match("/^[A-Z][A-Za-z -]*$/",$firstName)){
        die("Bad first name!");
    }
    $lastName = sanitized_input($_POST["lastName"]);
    if(!preg_match("/^[A-Z][A-Za-z -]*$/",$lastName)){
        die("Bad last name!");
    }
    $email = sanitized_input($_POST["email"]);
    if(!preg_match("/^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})$/",$email)){
        die("Bad e-mail!");
    }
    $phoneNumber = sanitized_input($_POST['phone']);
    $phoneNumber = !empty($_POST['phone']) ? $_POST['PHONE']: "Not given";
    if(!empty($_POST['phone']) && !preg_match("/^(\d{3}-)?\d{3}-\d{4}$/",$phoneNumber))
        {
            die("Bad phone number!");
        }
    $subject = sanitized_input($_POST['subject']);
    $message = sanitized_input($_POST['message']);
}

function sanitized_input($data)
{
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);

    return $data;
}

//Step1

$messageToBusiness = 
    "From: $salutation $firstName $lastName\r\n".
    "E-mail address: $email\r\n".
    "Phone number: $phoneNumber\r\n".
    "_______________________\r\n".
    "Subject: $subject\r\n".
    "________________________\r\n".
    "$message\r\n".
    "________________________\r\n";

//Send e-mail feedback message to the business
//(but here, to the text's website)
$headerToBusiness = "From: $email\r\n";
mail("u50@mail.cs.smu.ca", $subject,
    $messageToBusiness, $headerToBusiness);

//Construct e-mail confirmation message for the client,
//which is just a sligtly modified version of the message
//that went to the business
$messageToClient =
    "Dear $salutation $lastName:\r\n".
    "The following message was received from you by Platinum-ish:\r\n\r\n".
    $messageToBusiness.
    "========================\r\n".
    "Thank you for your interest and your feedback.\r\n".
    "The Platinum-ish Team\r\n".
    "========================\r\n";
     
if (isset($_POST['reply'])) $messageToClient.="P.S. We will 
    contact you shortly with more information.";

//Sends e-mail confirmation message to the client
$headerToClient = "From: u50@mail.cs.smu.ca\r\n";
mail($email, "Re: $subject",
    $messageToClient, $headerToClient);

//Transforms confirmation message to HTML format for display
//in the client's browser
$display = str_replace("\r\n", "\r\n<br>", $messageToClient);
$display = "<!DOCTYPE html>
    <html lang='en'>
    <head><meta charset='utf-8'><title>Your Message</title></head>
    <body><code>$display</code></body>
    </html>";
echo $display;

//Logs the message in data/feedback.txt on the web server
//Note: directory "data" is at same level as directory "scripts"
$fileVar = fopen("../data/feedback.txt", "a")
    or die("Error: Could not open the log file.");
fwrite($fileVar,
    "\n-------------------------------------------------------\n")
    or die("Error: Could not write divider to the log file.");
fwrite($fileVar, "Date received: ".date("jS \of F, Y \a\\t H:i:s\n"))
    or die("Error: Could not write date to the log file.");
fwrite($fileVar, $messageToBusiness)
    or die("Error: Could not write message to the log file.");
?>