<?php

header("Location: ../home.html");

include "../model/db_access.php";
include "../view/Revenue.php";

session_start();
try {
    $worker = new DB_access($_SESSION["username"], $_SESSION["password"]);
}
catch (Exception $e) {
    header("Location: ../login.html");
    exit();
}

//  Change the $_SESSION["view_revenue"]
$_SESSION["view_revenue"] = !$_SESSION["view_revenue"];

$revenue = new Revenue("../home.html", "revenue");

//  Rewrite the visibility of the revenue
if ($_SESSION["view_revenue"]) {
    $revenue->update($worker->get_revenue(date('Y')));
    $revenue->make_visible();
}
else {
    $revenue->make_hidden();            
}

?>