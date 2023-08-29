<?php

include "../view/Popup.php";

$error_popup = new Popup("../add_tour.html", "popup");
$error_popup->make_hidden();

header("Location: ../add_tour.html");

?>