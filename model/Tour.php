<?php
include "TourAction.php";

class Tour {
    public $index;
    public $name;
    public $picture_link;
    public $start_day;                  //YYYY-MM-DD
    public $passenger_num;
    public $prices;
    public $passenger_group_num_min;
    public $day_num;
    public $night_num;
    public $branch_index;
    public $tour_actions;

    function __construct() {
        $this->index = "";
        $this->name = "";
        $this->picture_link = "";
        $this->start_day = "";
        $this->passenger_num = [0,0];
        $this->prices = [0,0,0,0];
        $this->passenger_group_num_min = 0;
        $this->day_num = 0;
        $this->night_num = 0;
        $this->branch_index = "";
        $this->tour_actions = [];
    }

    function load($tour_idx, $connector) {
        $this->index = $tour_idx;
        $tour_info = $connector->query("SELECT * FROM tour WHERE Matour = '$tour_idx'")->fetch_assoc();
        if ($tour_info != null) {
            //  Load the information
            $this->name = $tour_info["Tentour"];
            $this->picture_link = $tour_info["Anh"];
            $this->start_day = $tour_info["Ngaybatdau"];
            $this->passenger_num = [$tour_info["Sokhachtourtoithieu"], $tour_info["Sokhachtourtoida"]];
            $this->prices = [$tour_info["Giavelenguoilon"], $tour_info["Giaveletreem"], $tour_info["Giavedoannguoilon"], $tour_info["Giavedoantreem"]];
            $this->passenger_group_num_min = $tour_info["Sokhachdoantoithieu"];
            $this->day_num = $tour_info["Songay"];
            $this->night_num = $tour_info["Sodem"];
            $this->branch_index = $tour_info["Machinhanh"];
            $this->tour_actions = [];

            //  Load the actions
            $connector->query("SET @id='$tour_idx'");
            $result_query = $connector->query("CALL `Scheduling`(@id)") ;
            while ($row = $result_query->fetch_assoc()) {
                if ($row["Loaihanhdong"]!="") {
                    $action = new TourAction(1, $row["STTngay"], $row["Loaihanhdong"], $row["Giobatdau"], $row["Gioketthuc"], $row["Mota"]);
                }
                else {
                    $action = new TourAction(2, $row["STTngay"], $row["Madiemdulich"], $row["Giobatdau"], $row["Gioketthuc"], $row["Mota"]);
                }
                $this->tour_actions[] = $action;
            }
            $connector->next_result();
        }
        else {
            throw new Exception("The tour index $tour_idx is incorrect!");
        }
    }

    function save($connector) {
        $connector->query("SET @p0=''");
        $connector->query("SET @p1='" . $this->name . "'");
        $connector->query("SET @p2='" . $this->picture_link . "'");
        $connector->query("SET @p3='" . $this->start_day . "'");
        $connector->query("SET @p4='" . $this->passenger_num[0] . "'");
        $connector->query("SET @p5='" . $this->passenger_num[1] . "'");
        $connector->query("SET @p6='" . $this->prices[0] . "'");
        $connector->query("SET @p7='" . $this->prices[1] . "'");
        $connector->query("SET @p8='" . $this->prices[2] . "'");
        $connector->query("SET @p9='" . $this->prices[3] . "'");
        $connector->query("SET @p10='" . $this->passenger_group_num_min . "'");
        $connector->query("SET @p11='" . $this->night_num . "'");
        $connector->query("SET @p12='" . $this->day_num . "'");
        $connector->query("SET @p13='" . $this->branch_index . "'");
        $connector->query("CALL add_tour(@p0,@p1,@p2,@p3,@p4,@p5,@p6,@p7,@p8,@p9,@p10,@p11,@p12,@p13)");
        return $connector->query("SELECT @p0 AS Matour")->fetch_assoc()["Matour"];
    }
}

?>