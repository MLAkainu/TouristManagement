<?php

include "../model/db_access.php";
include "../view/Popup.php";
include "../view/Revenue.php";

if (isset($_POST["submit_login"])) {
    session_start();
    $_SESSION["username"] = $_POST["username"];
    $_SESSION["password"] = $_POST["password"];
    $_SESSION["view_revenue"] = false;
    $popup = new Popup("../login.html", "popup");
    try {
        $worker = new DB_access($_SESSION["username"], $_SESSION["password"]);
        $popup->make_hidden();

        $revenue = new Revenue("../home.html", "revenue");
        $revenue->make_hidden();

        header("Location: ../home.html");
    }
    catch (Exception $e) {
        //$popup->update("You have logged in fail!" . $e->__toString());
        $popup->make_visible();

        header("Location: ../login.html");
    }
}
else {
    echo "Gì đây gì đây? Tính login mà không cung cấp thông tin à? Ra chỗ khác chơi giùm đi ạ";
}
?>