package com.hpcl.service;

import com.hpcl.model.Product;
import com.hpcl.repository.ProductRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;
import java.util.Map;

@Service
public class ProductSearchService {

    private final ProductRepository productRepository;

    public ProductSearchService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public List<Map<String, Object>> searchProducts(String query) {
        List<Product> products = productRepository.searchProducts(query);
        
        // Convert Product objects to List of Maps (if required for response)
        return products.stream().map(product -> Map.of(
                "id", product.getId(),
                "name", product.getName(),
                "description", product.getDescription(),
                "price", product.getPrice()
        )).collect(Collectors.toList());
    }
}
