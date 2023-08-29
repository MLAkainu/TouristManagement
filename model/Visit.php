<?php

class Visit {
    private $name;
    private $addresses;
    private $pictures;
    private $description;
    private $note;

    function __construct() {
        $this->name = "";
        $this->addresses = ["", "", "", ""];
        $this->pictures = ["", "", ""];
        $this->description = "";
        $this->note = "";
    }

    function load($name, $adds, $pictures, $des, $note) {
        $this->name = $name;
        $this->addresses = $adds;
        $this->pictures = $pictures;
        $this->description = $des;
        $this->note = $note;
    }

    function save($connector) {
        $connector->query("INSERT INTO diemdulich (Tendiem, Diachi, PhuongXa, QuanHuyen, TinhThanh, Anh1, Anh2, Anh3, Mota, Ghichu) VALUES ('". $this->name ."','','". $this->addresses[0] ."','". $this->addresses[1] ."','". $this->addresses[2] ."','". $this->pictures[0] ."','". $this->pictures[1] ."','". $this->pictures[2] ."','". $this->description ."','". $this->note ."')");
    }
}

?>