<?php

include_once "Element.php";

class Place_list extends Element {
    function update($place_list) {
        $this->element->nodeValue = "";
        foreach ($place_list as $place_index => $place_name) {
            $option = $this->dom->createElement("option", $place_name);
            $option->setAttribute("value", $place_index);
            $this->element->appendChild($option);
        }
        $this->dom->saveHTMLFile($this->html_file);
    }
}

?>