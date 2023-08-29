<?php

include_once "Element.php";

class Container extends Element {
    function update($search_list) {
        $this->element->nodeValue = "";
        foreach ($search_list as $tour) {
            $card = $this->dom->createElement("div");
            $card->setAttribute("class", "card");
            $card->setAttribute("style", "width: 300px;margin-top: 15px;margin-right: 15px;margin-bottom: 15px;margin-left: 15px; background: rgb(255 255 255 / 60%);");
            $this->element->appendChild($card);
        
            $card_body = $this->dom->createElement("div");
            $card_body->setAttribute("class", "card-body text-center");
            $card->appendChild($card_body);
        
            $img = $this->dom->createElement("img");
            $img->setAttribute("style", "width: 200px;min-width: 200px;max-width: 200px;height: 200px;min-height: 200px;background: url(\"" . $tour[2] . "\") center / cover no-repeat;max-height: 200px;");
            $card_body->appendChild($img);
        
            $h4 = $this->dom->createElement("h4", $tour[1]);
            $h4->setAttribute("class", "card-title");
            $card_body->appendChild($h4);
        
            $h6 = $this->dom->createElement("h6", $tour[0]);
            $h6->setAttribute("class", "text-muted card-subtitle mb-2");
            $card_body->appendChild($h6);
        
            $a = $this->dom->createElement("a", "Click here for tour detail");
            $a->setAttribute("class", "card-link");
            $a->setAttribute("href", "controller/get_tour_detail.php?index=" . $tour[0]);
            $card_body->appendChild($a);
        }
        $this->dom->saveHTMLFile($this->html_file);
    }

    function empty() {
        $this->element->nodeValue = "";
        $this->dom->saveHTMLFile($this->html_file);
    }
}

?>ss