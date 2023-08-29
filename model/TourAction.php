<?php

class TourAction {
    public $type;       //0 is null, 1 is action, 2 is place
    public $day_index;
    public $index;
    public $start_hour;
    public $end_hour;
    public $description;

    function __construct($type, $day_idx, $idx, $start, $end, $des) {
        $this->type = $type;
        $this->day_index = $day_idx;
        $this->index = $idx;
        $this->start_hour = $start;
        $this->end_hour = $end;
        $this->description = $des;
    }

    function save($tour_idx, $connector) {
        if ($this->type==1) {
            $table_name = "hanhdonglichtrinhtour";
        }
        else if ($this->type==2) {
            $table_name = "tourgomddtq";
        }
        else {
            throw new Exception("Invalid type of action to be inserted in database!");
        }
        
        try {
            $connector->query("INSERT INTO $table_name VALUES ('$tour_idx', ". $this->day_index .", ". $this->index .", '". $this->start_hour ."', '". $this->end_hour ."', '". $this->description ."')");
        }
        catch (Exception $e) {
            echo $e->__toString();
        }
    }
}

?>