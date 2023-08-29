<?php
include_once "Element.php";

class Added_list extends Element {
    private $action_list;

    function __construct($html_file, $id) {
        $this->html_file = $html_file;
        $this->dom = new DOMDocument();
        $this->dom->loadHTMLFile($html_file);
        $this->element = $this->dom->getElementById($id);
        $this->action_list = ["", "Start the tour", "End the tour", "Have breakfast", "Have lunch", "Have dinner", "Check in", "Check out", "Move"];
    }

    function make_empty() {
        $this->element->nodeValue = "";
        $this->dom->saveHTMLFile($this->html_file);
    }

    function update($actions, $place_list, $child_type) {   
        $this->element->nodeValue = "";

        foreach ($actions as $action) {
            $item = $this->dom->createElement($child_type);
            $item->setAttribute("style", "color: #94eaf4;");
            $item->nodeValue = "Day " . $action->day_index . ": ";
            if ($action->type == 1) {
                $item->nodeValue .= $this->action_list[$action->index];
            }
            else if ($action->type == 2) {
                $item->nodeValue .= "Visit at " . $place_list[$action->index];
            }
            $item->nodeValue .= " from " . $action->start_hour . " to " . $action->end_hour;
            if ($action->description) {
                $item->nodeValue .= " (" . $action->description . ")";
            }
            $this->element->appendChild($item);
        }
        $this->dom->saveHTMLFile($this->html_file);
    }
}

?>