<?php

include "../view/Container.php";

$container = new Container("../manage_tour.html", "Container");
$container->empty();

header("Location: ../manage_tour.html")

?>