package com.hpcl.repository;
import java.util.List;
//import com.hpcl.model.productModel;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.hpcl.model.ProductModel;

import jakarta.transaction.Transactional;
@Repository
public interface ProductRepository extends JpaRepository<ProductModel, Integer> {

	@Query("SELECT p FROM ProductModel p WHERE p.productType = :productType")
	 List<ProductModel> findByProductType(String productType);
		
	@Modifying
	@Transactional
	@Query("DELETE FROM ProductModel p WHERE p.productName = :productName")
	int deleteByProductName(@Param("productName") String productName);


	@Query(value = "SELECT * FROM products ORDER BY CAST(product_price AS DECIMAL) DESC LIMIT 3;", nativeQuery = true)
	List<ProductModel> findTop3ExpensiveProducts();

	
	@Query(value = "SELECT * FROM products WHERE LOWER(product_name) LIKE LOWER(CONCAT('%', :keyword, '%'))", nativeQuery = true)
	List<ProductModel> searchProduct(@Param("keyword")String word);

	@Query(value = "SELECT p FROM ProductModel p WHERE p.productId = :productId", nativeQuery = true)
	Optional<ProductModel> findProductById(@Param("productId") Integer productId);
	
	@Modifying
	@Query(value = "UPDATE ProductModel p SET p.productName = :name, p.productPrice = :price WHERE p.productId = :id, ORDER BY p.productId ASC", nativeQuery =  true)
	void updateProduct(@Param("id")Integer id, @Param("name")String name, @Param("price")String price);
	
	@Query("SELECT p FROM ProductModel p ORDER BY p.productId ASC")
	List<ProductModel> findAllSorted();

}
	
	
