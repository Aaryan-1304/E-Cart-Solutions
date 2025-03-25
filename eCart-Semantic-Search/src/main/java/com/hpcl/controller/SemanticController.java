package com.hpcl.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.hpcl.model.SemanticModel;
import com.hpcl.service.SemanticService;

@RestController  
@RequestMapping("/api")
public class SemanticController {
    
    @Autowired
    private SemanticService semanticService;

    @GetMapping(path = "/semanticSearch/{searchInput}", produces = "application/json")
    public List<SemanticModel> semanticSearch(@PathVariable("searchInput") String searchInput) {
        return semanticService.semanticSearch(searchInput);
    }
}

