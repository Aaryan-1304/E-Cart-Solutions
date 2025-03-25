package com.hpcl.service;

import com.hpcl.model.EcartModel;
import com.hpcl.model.ProductModel;
import com.hpcl.repository.EcartRepository;
import com.hpcl.repository.ProductRepository;
import EcartDetailsDTO.ProductDTO;
import jakarta.transaction.Transactional;

import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
        return productRepository.searchProducts(word);
    }

    public List<ProductModel> findProductsByIds(List<Integer> productIds) {
        return productRepository.findProductsByIds(productIds);
    }

	public void updateProduct(ProductModel updatedProduct) {
		Optional<ProductModel> existingProduct = productRepository.findById(updatedProduct.getProductId());
		if(existingProduct.isPresent()) {
			ProductModel product = existingProduct.get();
			product.setProductName(updatedProduct.getProductName());
			product.setProductType(updatedProduct.getProductType());
			product.setProductPrice(updatedProduct.getProductPrice());
			product.setProductImage(updatedProduct.getProductImage());
			productRepository.save(product);
		}
	}
	
	public class InsufficientInventoryException extends RuntimeException {
	    
	    public InsufficientInventoryException(String message) {
	        super(message);
	    }
	    
	    public InsufficientInventoryException(String message, Throwable cause) {
	        super(message, cause);
	    }
	}
	
	public void productQuantity(ProductModel updatedProduct) {
	    Optional<ProductModel> existingProductOptional = productRepository.findById(updatedProduct.getProductId());
	    
	    if (existingProductOptional.isPresent()) {
	        ProductModel existingProduct = existingProductOptional.get();
	        int quantityAtCheckout = updatedProduct.getQuantity();
	        int quantityInDb = existingProduct.getQuantity();
	        
	        if (quantityInDb >= quantityAtCheckout) {
	            existingProduct.setQuantity(quantityInDb - quantityAtCheckout);
	            productRepository.save(existingProduct);
	        } else {
	            throw new InsufficientInventoryException("Not enough inventory available for product: " + existingProduct.getProductId());
	        }
	    }
	}

	public boolean updateProductQuantity(List<Integer> productIds, List<Integer> quantities) {
	    for (int i = 0; i < productIds.size(); i++) {
	        int productId = productIds.get(i);
	        int quantityToReduce = quantities.get(i);

	        ProductModel product = productRepository.findById(productId).orElse(null);
	        if (product != null && product.getQuantity() >= quantityToReduce) {
	            product.setQuantity(product.getQuantity() - quantityToReduce);
	            productRepository.save(product);
	        } else {
	            return false;
	        }
	    }
	    return true; 
	}
    
    public void ProductSearchService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public List<ProductModel> searchProducts(String query) {
        List<ProductModel> results = productRepository.searchProducts(query);
        return results != null ? results : new ArrayList<>();
    }


}