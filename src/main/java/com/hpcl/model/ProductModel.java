package com.hpcl.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "products")
public class ProductModel {

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Integer productId;

    @Column(name = "product_category")
    private String productType;

    @Column(name = "product_price")
    private String productPrice;

    @Column(name = "product_name")
    private String productName;

    @Column(name = "product_image")
    private String productImage;
    
    // Default Constructor
    public ProductModel() {
        super();
    }
    private int quantity;

    // Parameterized Constructor
    public ProductModel(String productType, String productPrice, String productName, Integer productId, String productImage) {
        this.productType = productType;
        this.productPrice = productPrice;
        this.productName = productName;
        this.productId = productId;
        this.productImage = productImage;
        this.quantity = 1;
     
    }
    public int getQuantity() {
    	return quantity;
    }
    public void setQuantity(int quantity) {
    	 this.quantity = quantity;
    }

    public String getProductImage() {
		return productImage;
	}
    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }
	// Getters and Setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }
    
    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType;
    }

    public String getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(String productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
}
