<?php

include_once "Element.php";

class Day_limit extends Element {
    function set_limit($limit) {
        $this->element->setAttribute("max", $limit);
        $this->dom->saveHTMLFile($this->html_file);
    }
}

?>