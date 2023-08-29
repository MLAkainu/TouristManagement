<?php

header("Location: ../manage_tour.html");

include "../model/db_access.php";
include "../view/Container.php";

session_start();
try {
    $worker = new DB_access($_SESSION["username"], $_SESSION["password"]);
}
catch (Exception $e) {
    header("Location: ../login.html");
    exit();
}


//  Update the page and return to it
$container = new Container("../manage_tour.html", "Container");
$container->update($worker->search_tours_by_name($_GET["name"]));

?>