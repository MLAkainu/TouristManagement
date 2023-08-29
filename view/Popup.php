<?php

include_once "Element.php";

class Popup extends Element {
    function make_visible() { 
        $this->element->setAttribute("style", "visibility: visible");
        $this->dom->saveHTMLFile($this->html_file);
    }

    function make_hidden() {
        $this->element->setAttribute("style", "visibility: hidden");
        $this->dom->saveHTMLFile($this->html_file);
    }

    function update($information) {
        $this->element->nodeValue = $information;
        $close_btn = $this->dom->createElement("span", "&times;");
        $close_btn->setAttribute("class", "closebtn");
        $close_btn->setAttribute("onclick", "this.parentElement.style.display='none';");
        $this->element->appendChild($close_btn);
        $this->dom->saveHTMLFile($this->html_file);
    }
}

?>