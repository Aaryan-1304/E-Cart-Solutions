package com.hpcl.service;

import com.hpcl.model.EcartModel;
import com.hpcl.model.ProductModel;
import com.hpcl.repository.EcartRepository;
import com.hpcl.repository.ProductRepository;
import EcartDetailsDTO.ProductDTO;
import jakarta.transaction.Transactional;

import java.util.Base64;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductService {
    
    @Autowired
    private ProductRepository productRepository;
    
    public List<ProductModel> findAllProducts(){
        return productRepository.findAll();
    }
         
    public List<ProductModel> findProductsByType(String productType) {
        return productRepository.findByProductType(productType);
    }

    public ProductModel saveProduct(ProductModel newProduct) {
        return productRepository.save(newProduct);
    }

    public int removeProduct(String productName) {
        return productRepository.deleteByProductName(productName);
    }

    public List<ProductModel> findTop3ExpensiveProducts() {
        return productRepository.findTop3ExpensiveProducts();
    }

    public List<ProductModel> searchProduct(String word) {
        return productRepository.searchProduct(word);
    }

	public Optional<ProductModel> findProductById(Integer productId) {
		return productRepository.findById(productId);
	}
}