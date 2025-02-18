//package com.hpcl.model;
//
//public class cartModel {
//	import jakarta.persistence.*;
//
//	@Entity
//	@Table(name = "cart")
//	public class CartItem {
//
//	    @Id
//	    @GeneratedValue(strategy = GenerationType.IDENTITY)
//	    private Long id;
//
//	    @Column(name = "user_id")
//	    private String userId;
//
//	    @Column(name = "product_id")
//	    private String productId;
//
//	    // Constructors, getters, and setters
//	    public CartItem() {}
//
//	    public CartItem(String userId, String productId) {
//	        this.userId = userId;
//	        this.productId = productId;
//	    }
//
//	    public String getUserId() {
//	        return userId;
//	    }
//
//	    public void setUserId(String userId) {
//	        this.userId = userId;
//	    }
//
//	    public String getProductId() {
//	        return productId;
//	    }
//
//	    public void setProductId(String productId) {
//	        this.productId = productId;
//	    }
//	}
//}
