<?php

include "../model/db_access.php";
include "../view/Popup.php";

session_start();
try {
    $worker = new DB_access($_SESSION["username"], $_SESSION["password"]);
}
catch (Exception $e) {
    header("Location: ../login.html");
    exit();
}

if (isset($_POST["submit_add_visit"])) {
    $visit = new Visit();

    //  Relocation the uploaded files
    $picture_links = $_POST["file"];

    $visit->load($_POST["destination"], [$_POST["ward"], $_POST["district"], $_POST["province"], $_POST["province"]], $picture_links, $_POST["description"], $_POST["note"]);
    $worker->save_visit($visit);

    //  Print out notification
    $notifier = new Popup("../add_visit.html", "popup");
    $notifier->make_visible();

    header("Location: ../add_visit.html");
}
else {
    echo "There is no visit added, what are you doing?";
    die();
}

?>