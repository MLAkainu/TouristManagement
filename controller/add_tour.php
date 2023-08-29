<?php

include "../model/db_access.php";
include "../view/Popup.php";
include "../view/Day_limit.php";
include "../view/Place_list.php";
include "../view/Added_list.php";

session_start();
try {
    $worker = new DB_access($_SESSION["username"], $_SESSION["password"]);
}
catch (Exception $e) {
    header("Location: ../login.html");
    exit();
}

if (isset($_POST["add_tour"])) {
    $new_tour = new Tour();
    $new_tour->index = "new_one";
    $new_tour->name = $_POST["tour_name"];
    $new_tour->picture_link = $_POST["picture_link"];
    $new_tour->start_day = $_POST["start_day"];
    $new_tour->passenger_num = [$_POST["min_passenger"], $_POST["max_passenger"]];
    $new_tour->prices = [$_POST["adult_alone"], $_POST["child_alone"], $_POST["adult_group"], $_POST["child_group"]];
    $new_tour->passenger_group_num_min = $_POST["min_group"];
    $new_tour->day_num = $_POST["num_day"];
    $new_tour->night_num = $_POST["num_night"];
    $new_tour->branch_index = $_POST["branch_idx"];

    //  Try to save into database and get return the tour index
    $new_tour->index = $worker->save_tour($new_tour);

    $error_popup = new Popup("../add_tour.html", "popup");
    //  If it cannot be saved
    if (gettype($new_tour->index) != "string") {
        header("Location: ../add_tour.html");
        $error_popup->make_visible();
    }
    //  If it is saved successfully
    else {
        //  Save and redirect to add_tour_detail.html or add_tour_start_days.html
        if ($new_tour->day_num==1) {
            header("Location: ../add_tour_detail.html");
        }
        else {
            header("Location: ../add_tour_departure_days.html");
        }

        $error_popup->make_hidden();
        $_SESSION["new_tour_idx"] = $new_tour->index;

        //  Add day limit to add_tour_detail.html
        $day = new Day_limit("../add_tour_detail.html", "Day_place");
        $day->set_limit($new_tour->day_num);
        $day = new Day_limit("../add_tour_detail.html", "Day_action");
        $day->set_limit($new_tour->day_num);
        
        //  Update the place list
        $place_list = new Place_list("../add_tour_detail.html", "Group");
        $place_list->update($worker->get_place_list());

        //  Make the added action list empty
        $added_list = new Added_list("../add_tour_detail.html", "List");
        $added_list->make_empty();
    }
}
else {
    echo "Bạn đã xâm nhập trái phép file của chúng tôi, xin mời bạn cút cho giùm đi ạ";
    die();
}


?>