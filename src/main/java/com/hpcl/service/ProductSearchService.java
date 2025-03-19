//package com.hpcl.service;
//
//import com.hpcl.model.ProductModel;
//import com.hpcl.repository.ProductRepository;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//@Service
//public class ProductSearchService {
//    private final ProductRepository productRepository;
//
//    @Autowired
//    public ProductSearchService(ProductRepository productRepository) {
//        this.productRepository = productRepository;
//    }
//
//    public List<Map<String, Object>> searchProducts(String query) {
//        List<ProductModel> products = productRepository.searchProducts(query);
//
//        List<Map<String, Object>> result = new ArrayList<>();
//        for (ProductModel product : products) {
//            Map<String, Object> productMap = new HashMap<>();
//            productMap.put("id", product.getProductId());
//            productMap.put("name", product.getProductName());
//            productMap.put("description", product.getProductDescription() != null ?
//                product.getProductDescription() : "No description available");
//            productMap.put("price", product.getProductPrice());
//
//            result.add(productMap);
//        }
//        return result;
//    }
//}
