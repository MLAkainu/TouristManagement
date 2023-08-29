<?php

class Element {
    protected $html_file;
    protected $dom;
    protected $element;

    function __construct($html_file, $id) {
        $this->html_file = $html_file;
        $this->dom = new DOMDocument();
        $this->dom->loadHTMLFile($html_file);
        $this->element = $this->dom->getElementById($id);
        /*if (isset($this->element)) {
            echo "I was born, I am $id in $html_file </br>";
        }
        else {
            echo "I was dead, I am $id in $html_file </br>";
        }*/
    }
}

?>