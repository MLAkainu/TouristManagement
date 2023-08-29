<?php

include_once "Element.php";

class Revenue extends Element {
    function update($revenue_list) {
        for ($idx=1;$idx<=12;$idx++) {
            $revenue_month = $this->dom->getElementById("month_" . $idx);
            if ($revenue_list[$idx-1] != 0) {
                $revenue_month->nodeValue = "Tháng " . $idx . ": " . $revenue_list[$idx-1] . " VNĐ";
            }
            else {
                $revenue_month->nodeValue = "Tháng " . $idx . ": 0 VNĐ";
            }
        }
    }

    function make_visible() {
        $this->element->setAttribute("style", "width: 400px;min-width: 400px;max-width: 400px;height: 700px;min-height: 700px;max-height: 700px;margin-right: 0px;padding-right: 0px;background: #000000;opacity: 0.69;backdrop-filter: opacity(1);");
        $this->dom->saveHTMLFile($this->html_file);
    }

    function make_hidden() {
        $this->element->setAttribute("style", "width: 400px;min-width: 400px;max-width: 400px;height: 700px;min-height: 700px;max-height: 700px;margin-right: 0px;padding-right: 0px;background: #000000;opacity: 0;backdrop-filter: opacity(1);");
        $this->dom->saveHTMLFile($this->html_file);
    }
}

?>