<?php

include "../model/db_access.php";

session_start();
try {
    $worker = new DB_access($_SESSION["username"], $_SESSION["password"]);
}
catch (Exception $e) {
    header("Location: ../login.html");
    exit();
}

if (isset($_POST["add_departure_days"])) {
    header("Location: ../add_tour_detail.html");

    //  Add days into a list
    $departure_days = array_keys($_POST);
    array_pop($departure_days);

    //  Save these days into database
    $worker->save_tour_departure_days($_SESSION["new_tour_idx"], $departure_days);
}
else {
    "This site is not for you, please move away!";
    die();
}

?>