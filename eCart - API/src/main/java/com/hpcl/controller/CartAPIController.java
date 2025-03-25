package com.hpcl.controller;

import com.hpcl.model.APIModel;
import com.hpcl.service.APIService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api")
public class CartAPIController {
    
    @Autowired
    private APIService apiService;

    @GetMapping("/searchProducts/{searchInput}")
    public List<APIModel> searchProducts(@PathVariable("searchInput") String searchInput) {
        return apiService.searchProducts(searchInput);
    }
   }
