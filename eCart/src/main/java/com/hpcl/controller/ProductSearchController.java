//package com.hpcl.controller;
//
//import java.util.List;
//import java.util.Map;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.apache.commons.lang3.StringUtils;
//import com.hpcl.service.ProductSearchService;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//
//
//@Controller
//public class ProductSearchController {
//    
//    @Autowired
//    private ProductSearchService productSearchService;
//    private static final Logger log = LoggerFactory.getLogger(ProductSearchController.class);
//    @GetMapping("/searchProducts")
//    public String searchProducts(@RequestParam(value = "searchInput", required = false) String query, Model model) {
//        if (StringUtils.isNotEmpty(query)) {
//            try {
//                List<Map<String, Object>> searchResults = productSearchService.searchProducts(query.trim());
//                model.addAttribute("searchResults", searchResults);
//                model.addAttribute("searchInput", query.trim());
//            } catch (Exception e) {
//                model.addAttribute("error", "An error occurred while searching for products.");
//                log.error("Error during product search: {}", e.getMessage(), e);
//            }
//        }
//        return "searchResults";
//    }
//}