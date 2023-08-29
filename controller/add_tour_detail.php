<?php

include "../model/db_access.php";
include "../view/Added_list.php";
session_start();
try {
    $worker = new DB_access($_SESSION["username"], $_SESSION["password"]);
}
catch (Exception $e) {
    header("Location: ../login.html");
    exit();
}

//  If add a new action
if (isset($_POST["add_action"])) {
    $new_tour_action = new TourAction(1, $_POST["day_idx"], $_POST["action"], $_POST["start_hour"], $_POST["end_hour"], $_POST["description"]);
    $worker->save_tour_action($_SESSION["new_tour_idx"], $new_tour_action);
}

//  If add a new place
else if (isset($_POST["add_place"])) {
    $new_tour_action = new TourAction(2, $_POST["day_idx"], $_POST["place"], $_POST["start_hour"], $_POST["end_hour"], $_POST["description"]);
    $worker->save_tour_action($_SESSION["new_tour_idx"], $new_tour_action);
}

//  If not above
else {
    echo "Bạn không có quyền truy cập vào trang web này, xin mời bạn rời đi cho!";
    die();
}

$added_list = new Added_list("../add_tour_detail.html", "List");
$added_list->update($worker->get_tour_detail($_SESSION["new_tour_idx"])->tour_actions, $worker->get_place_list(), "li");

header("Location: ../add_tour_detail.html")

?>