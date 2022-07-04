<?php
/*formRegistrationProcess.php
//Calls these functions (defined below):
//emailAlreadyExists()
//getUniqueLoginName()
Enters the customer's information from the registration
form into the database. Fails if the user does not have
an e-mail address that is unique in the database. The
login name requested by the user does not have to be 
unique, but if this is not the case, the script choses
a modified login name (based on the user's requested
login name) that is unique.
*/


// session_start();
// $secure = $_SESSION['SECURE'];
// if($secure != "!@#$^%FDSSFDWQR@"){
//     die('SECURE test failed.');
// }
// if file location changes, modify the $origin url.
// $origin = $_SESSION['ORIGIN']; 
// if($origin != "/~u23/public_html/submissions/submission06/pages/formFeedback.php"){
//     die('SECURE test failed.');
// }

$salutation = $firstName = $middleInitial= $lastName = "";
$gender = $email = $phone = $street = "";
$city = $region = $postalCode = "";
$loginName = $password1 = $password2 = "";

if($_SERVER["REQUEST_METHOD"] == "POST")
{
    $salutation = sanitized_input($_POST["salutation"]);
    $firstName = sanitized_input($_POST["firstName"]);

    if(!preg_match("/^[A-Z][A-Za-z -]*$/",$firstName)){
        die("Bad first name!");
    }
    $middleInitial = sanitized_input($_POST["middleInitial"]);
    if(!empty($_POST['middleInitial']) && !preg_match("/^[A-Z]{\.}?$/",$middleInitial))
        {
            die("Bad middle Initial!");
        }
    $lastName = sanitized_input($_POST["lastName"]);
    if(!preg_match("/^[A-Z][A-Za-z -]*$/",$lastName)){
        die("Bad last name!");
    }
    $gender = sanitized_input($_POST["gender"]);

    $email = sanitized_input($_POST["email"]);
    if(!preg_match("/^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})$/",$email)){
        die("Bad e-mail!");
    }
    $phone = sanitized_input($_POST['phone']);
    
    if(!empty($_POST['phone']) && !preg_match("/^(\d{3}-)?\d{3}-\d{4}$/",$phone))
        {
            die("Bad phone number!");
        }

     $street = sanitized_input($_POST["street"]);
     if(empty($_POST['street']))
        {
            die("Missing Street Address!");
        }

     $city = sanitized_input($_POST["city"]);
     if(empty($_POST['city']))
       {
         die("Missing city!");
       }
     $region = sanitized_input($_POST["region"]);
     if(!preg_match("/^[A-Z]{2}$/",$region)){
        die("Bad region!");
    }

    $postalCode = sanitized_input($_POST["postalCode"]);
    if(!empty($_POST['postalCode']) &&
        !preg_match("/^[A-Z]\d[A-Z] ?\d[A-Z]\d$/", $postalCode))
    {
        die("Bad postal code!");
    }

    $loginName = sanitized_input($_POST["loginName"]);
     if(!preg_match("/^[A-Za-z][A-Za-z0-9]{5,14}$/",$loginName)){
        die("Bad login name!");
    }

    $password1 = sanitized_input($_POST["password1"]);
    $regex = "/^(?=.*\d)(?=.*[@^_+=[\]:])(?=.*[A-Z])(?=.*[a-z])\S{8,15}$/";
    if(!preg_match($regex, $password1)){
        die("Bad first password!");
    }
    $password2 = sanitized_input($_POST["password2"]);
    if(!preg_match($regex, $password2)){
        die("Bad second password!");
    }
}

function sanitized_input($data)
{
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);

    return $data;
}


//========== main script begins here
if (isset($_POST['gender']) && ($_POST['gender'] == "Female"))
    $gender = "F";
else if (isset($_POST['gender']) && ($_POST['gender'] == "Male"))
    $gender = "M";
else $gender = "O"; //for "Other"

if (emailAlreadyExists($db, $_POST['email']))
{
    echo "<h3>Sorry, but your e-mail
          address is already registered in our database. To register,
          you must use a different e-mail address.</h3>";
}
else if ($_POST['password1'] != $_POST['password2']){
    echo "<h3>Sorry, but the passwords you entered do not match.
    Your attempt to register has failed, Please try again.</h3>";
}
else
{
    $loginDateTime = date('Y-m-d h:i:s');
    $loginPassword = md5($_POST['password1']);
    $uniqueLoginName = getUniqueLoginName($db, $_POST['loginName']);
    if ($uniqueLoginName != $_POST['loginName'])
    {
        echo "<h3>Your preferred login name already exists.<br>So ...
              we have assigned $uniqueLoginName as your login name.</h3>";
    }
    $firstName = str_replace("'", "\'", $firstName);
    $lastName = str_replace("'", "\'", $lastName);

    $query = "INSERT INTO my_Customer(
        
        salutation,
        first_name, middle_initial, last_name,
        gender,
        email,phone,
        street, city, region, postal_code, date_time,
        login_name, login_password 
         
    )
    VALUES (
        
        '$salutation',
        '$firstName', '$middleInitial', '$lastName',
        '$gender',
        '$email','$phone',
        '$street', '$city', '$region', '$postalCode',
        '$loginDateTime',
        '$uniqueLoginName', '$loginPassword'
            
    );";
    if(mysqli_query($db, $query)){

        echo "<h3>Thank you for registering with Platinum-ish.<br>
             Your login username for our website is 
             \"$uniqueLoginName\".<br>
             Remember to record the password you supplied
             in a safe place.<br>
             To log in and start shopping in our e-store please
             <a href='pages/formLogin.php'>click here</a>.</h3>";
    }else {
        echo "<h3>Unable to register: </h3>".mysqli_error($db).
             " Error #".mysqli_errno($db);
    }
    
    
}
mysqli_close($db);
//========== main script ends here

/*emailAlreadyExists()
Determines if the e-mail address supplied by the customer
upon registration is already in the database.
*/
function emailAlreadyExists($db, $email)
{
    $query =
      "SELECT *
      FROM my_Customer 
      WHERE email = '$email'";
    $customers = mysqli_query($db, $query);
    if($customers){
        $numRecords = mysqli_num_rows($customers);
    }else {
        $numRecords = 0;
    }
   
    return ($numRecords > 0) ? true : false;
}

/*getUniqueLoginName()
Assigns a unique login name to the customer upon registration.
If the login name requested by the customer is already in use,
the customer will be assigned the login name which is formed
by taking the requested login name and appending the lowest
positive integer that makes the result unique in the database.
*/
function getUniqueLoginName($db, $loginName)
{
    $uniqueLoginName = $loginName;
    $query =
      "SELECT *
      FROM my_Customer
      WHERE login_name = '$uniqueLoginName'";
    $customers = mysqli_query($db, $query);
    $numRecords = mysqli_num_rows($customers);
    if ($numRecords != 0)
    {
        //Try appending non-negative integers 0, 1, 2 ...
        //till you get a unique login name
        $i = -1;
        do
        {
            $i++;
            $uniqueLoginName = $loginName.$i;
            $query =
              "SELECT *
              FROM my_Customer
              WHERE login_name = '$uniqueLoginName'";
            $customers = mysqli_query($db, $query);
            $numRecords = mysqli_num_rows($customers);
        }
        while ($numRecords != 0);
    }
    return $uniqueLoginName;
}
?>