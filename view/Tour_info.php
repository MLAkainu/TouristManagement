<?php

include_once "Element.php";

class Tour_info extends Element {
    function create_child($value) {
        $item = $this->dom->createElement("p", $value);
        $item->setAttribute("style", "color: #94eaf4;");
        $this->element->appendChild($item);
    }

    function update($tour, $departure_days) {
        $this->element->nodeValue = "";
        $this->create_child("Tour index: " . $tour->index);
        $this->create_child("Tour name: " . $tour->name);
        $this->create_child("Starting day: " . $tour->start_day);
        $this->create_child("Minimum number of passengers: " . $tour->passenger_num[0] . " person(s)");
        $this->create_child("Maximum number of passengers: " . $tour->passenger_num[1] . " person(s)");
        $this->create_child("Prices for adult going alone: " . $tour->prices[0] . " VNĐ");
        $this->create_child("Prices for child going alone: " . $tour->prices[1] . " VNĐ");
        $this->create_child("Prices for adult going as in group: " . $tour->prices[2] . " VNĐ");
        $this->create_child("Prices for adult going as in group: " . $tour->prices[3] . " VNĐ");
        $this->create_child("Minimum number of group members: " . $tour->passenger_group_num_min . " person(s)");
        $this->create_child("Number of nights: " . $tour->night_num . " night(s)");
        $this->create_child("Number of days: " . $tour->day_num . " day(s)");
        $this->create_child("Branch index: " . $tour->branch_index);
        if ($departure_days != NULL) {
            $this->create_child("Tour's departure days: " . $departure_days);
        }
        $this->dom->saveHTMLFile($this->html_file);
    }
}

?>