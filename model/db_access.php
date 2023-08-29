<?php
include "Tour.php";
include "Visit.php";

class DB_access {
    private $username;
    private $password;
    private $connector;

    // Login and create an connection
    function __construct($user, $pass) {
        $this->username = $user;
        $this->password = $pass;
        $this->connector = new mysqli("localhost", $this->username, $this->password, "assignment");
    }

    //  Get the name of the user
    function get_name() {
        return $this->username;
    }

    //  Add a tour into the database
    function save_tour($tour) {
        try {
            return $tour->save($this->connector);
        }
        catch (Exception $e) {
            return $e;
        }
    }

    //  Add tour's departure days
    function save_tour_departure_days($tour_idx, $tour_departure_list) {
        foreach ($tour_departure_list as $day) {
            $this->connector->query("INSERT INTO ngaykhoihanhtourdaingay VALUES('$tour_idx', $day)");
        }
    }

    //  Get tour's departure days as a string
    function get_tour_departure_days($tour_idx) {
        $result_query = $this->connector->query("SELECT * FROM ngaykhoihanhtourdaingay WHERE Matour='$tour_idx'");
        $str = "";
        while ($row = $result_query->fetch_assoc()) {
            $str .= $row["Ngay"] . ", ";
        }
        return substr($str, 0, -2);
    }

    //  Add a touraction into the database
    function save_tour_action($tour_idx, $tour_action) {
        try {
            $tour_action->save($tour_idx, $this->connector);
        }
        catch (Exception $e) {
            return $e;
        }
    }

    //  Add a new visit into the database
    function save_visit($visit) {
        try {
            $visit->save($this->connector);
        }
        catch (Exception $e) {
            return $e;
        }
    }

    //  Search tours by their names
    function search_tours_by_name($search_text) {
        $result_query = $this->connector->query("SELECT * FROM tour WHERE Tentour LIKE '%$search_text%'");
        $tour_list = [];
        while ($tour = $result_query->fetch_assoc()) {
            $tour_list[] = [$tour["Matour"], $tour["Tentour"], $tour["Anh"]];
        }
        return $tour_list;
    }

    //  Return detail of a tour
    function get_tour_detail($tour_idx) {
        $tour = new Tour();
        $tour->load($tour_idx, $this->connector);
        return $tour;
    }

    /*  Return the list of monthly revenues in a year
        The format is [$January_revenue, $Febuary_revenue, ...]
    */
    function get_revenue($year) {
        $this->connector->query("SET @year = $year");
        $result_query = $this->connector->query("CALL ThongKeDoanhThu(@year)");
        $result = [];
        while($row = $result_query->fetch_assoc()) {
            array_push($result, array_values($row)[1]);
        }
        return $result;
    }

    /*  Get the list of places in database
        The format is [[$index_1]->$name_1 [$index_2]->$name_2, ...]
    */
    function get_place_list() {
        $list = [];
        $result_query = $this->connector->query("SELECT Madiem, Tendiem FROM diemdulich");
        while ($row = $result_query->fetch_assoc()) {
            $list[$row["Madiem"]] = $row["Tendiem"];
        }
        $result_query->close();
        return $list;
    }
}

?>