<!-- banner.html -->
<!-- By Christophe Manzi -->

<body class="body w3-auto" onload="carousel()">
    <header class="w3-container">
        <div class="w3-border w3-border-black w3-light-grey">
            <div id="logo" class="w3-half">
                <img src="images/Platinum-ish_Logo.png" alt="Platinum-ish Logo" style="width: 100%">
            </div>

            <div class="w3-half w3-right-align">
                <div class="w3-panel">
                    <!-- <h4>
                        Welcome!
                    </h4> -->
                    <?php
                    
        //Ensure that session_start() is called at the
        //beginning of any file that includes this script
        //and needs to make use of the $_SESSION array.
        //Also because logout.php destroys the session 
        //before its final display it is necessary here
        //to check that the $_SESSION values are actually
        //set and available before using them.
        $loggedIn = isset($_SESSION['customer_id']) ? true : false;
        if (isset($_SESSION['customer_id']))
            $customerID = $_SESSION['customer_id'];
        if (isset($_SESSION['salutation']))
            $salutation = $_SESSION['salutation'];
        if (isset($_SESSION['first_name']))
            $firstName = $_SESSION['first_name'];
        if (isset($_SESSION['middle_initial']))
            $middleInitial = $_SESSION['middle_initial'];
        if (isset($_SESSION['last_name']))
            $lastName = $_SESSION['last_name'];
        if (!$loggedIn)
        {
            echo "<h5>Welcome!</h5>";
            // echo "loggedIn value: ".$loggedIn;
        }
        else
        {
            echo "<h6>$salutation $firstName $middleInitial $lastName
            ... Welcome, $firstName!</h6>";
        }
        $date = date("l, F jS");
        $time = date("g:ia");
        echo "<h6 id='datetime'>It's $date";
        echo "and our time is $time.</h6>";
        if ($loggedIn)
        {
            echo "<a  class='w3-button w3-blue w3-round w3-small' href='pages/logout.php'>
                        Click here to log out
                    </a>";
        }
        else
        {
            echo "<a  class='w3-button w3-blue w3-round w3-small' href='pages/formLogin.php'>
                        Click here to log in
                    </a>";
        }
        ?>
                    <!-- <h6 id="datetime">
                        It's Thursday, January 27th.<br>Our time is 10:41am.
                    </h6> -->
                    <!-- echo "<a  class='w3-button w3-blue w3-round w3-small' href='pages/formLogin.php'>
                        Click here to log in
                    </a>"; -->
                    <p class="quote w3-left-align">
                        <?php
                        // echo "the contetxt stuff : "
                        // $_SERVER['CONTEXT_DOCUMENT_ROOT'];
                        include $_SERVER['CONTEXT_DOCUMENT_ROOT']
                        ."/submissions/submission06"
                        ."/scripts/get_quote_from_mongodb.php"
                       
                        ?>

                    </p>
                </div>
            </div>
            <script>
            //This script sets up the AJAX infrastructure for 
            //requesting time updates from the server.
            var request = null;

            function getCurrentTime() {
                request = new XMLHttpRequest();
                var url = "scripts/time.php";
                request.open("GET", url, true);
                request.onreadystatechange = updatePage;
                request.send(null);
            }

            function updatePage() {
                if (request.readyState == 4) {
                    var dateDisplay = document.getElementById("datetime");
                    dateDisplay.innerHTML = request.responseText;
                }
            }
            getCurrentTime();
            setInterval('getCurrentTime()', 60000)
            </script>