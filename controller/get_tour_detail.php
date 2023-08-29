<?php

include "../model/db_access.php";
include "../view/Tour_info.php";
include "../view/Added_list.php";

session_start();
try {
    $worker = new DB_access($_SESSION["username"], $_SESSION["password"]);
}
catch (Exception $e) {
    header("Location: ../login.html");
    exit();
}

if (isset($_GET["index"])) {
    $tour = $worker->get_tour_detail($_GET["index"]);

    //  Update the tour information
    $info = new Tour_info("../view_tour.html", "Information");
    $info->update($tour, $worker->get_tour_departure_days($_GET["index"]));

    // Update the schedule
    $schedule = new Added_list("../view_tour.html", "Schedule");
    $schedule->update($tour->tour_actions, $worker->get_place_list(), "p");

    header("Location: ../view_tour.html");
}
else {
    header("Location: ../home.html");
}

?>