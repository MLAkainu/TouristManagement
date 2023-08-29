<?php

include "../view/Popup.php";

$notifier = new Popup("../add_visit.html", "popup");
$notifier->make_hidden();

header("Location: ../add_visit.html")

?>