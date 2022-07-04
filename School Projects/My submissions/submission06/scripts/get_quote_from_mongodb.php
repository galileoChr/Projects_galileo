<?php
//get_quote_from_mongodb.php

function create_quote_today()
{
    $f = fopen($_SERVER['CONTEXT_DOCUMENT_ROOT']
              ."/submissions/submission06"
              . "/resources/quote_today.txt", "w");
    fwrite($f, date("l, F jS") . "\n");
    require('/var/shared/vendor/autoload.php');
    require($_SERVER["CONTEXT_DOCUMENT_ROOT"]
            . '/../htpasswd/mongodb.inc');
    $client = new 
        MongoDB\Client("mongodb://$username:$password@localhost/u23");
    $collection = $client->u23->quotes_mongo;
    $quote_number = rand(1, $collection->count());
    $entry = $collection->findone( [ '_id' => $quote_number ] );
    $quote_today = "";
    $quote_today = "Today's "
        . $entry['adjective']
        . " quote, from "
        . $entry['author']
        . ":\n"
        . $entry['text'];
    fwrite($f, $quote_today);
    fclose($f);
    return $quote_today;
}

if (file_exists($_SERVER['CONTEXT_DOCUMENT_ROOT']
              ."/submissions/submission06"
              . "/resources/quote_today.txt"))
{
    $f = fopen($_SERVER['CONTEXT_DOCUMENT_ROOT']
              ."/submissions/submission06"
              . "/resources/quote_today.txt", "r");
    $date = trim(fgets($f));
    if ($date == date("l, F jS"))
    {
        $quote = fgets($f, 2000);
        $quote .= fgets($f, 2000);
        fclose($f);
        echo $quote;
    }
    else
    {
        fclose($f);
        unlink($_SERVER['CONTEXT_DOCUMENT_ROOT']
              ."/submissions/submission06"
              . "/resources/quote_today.txt");
        echo create_quote_today();
    }
}
else
{
    echo create_quote_today();
}
?>
