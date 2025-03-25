package com.hpcl.repository;

import java.util.ArrayList;
import java.util.List;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.hpcl.model.SemanticModel;

import jakarta.transaction.Transactional;

@Repository
public interface APIRepository extends JpaRepository<SemanticModel, Integer> {
    @Modifying
    @Transactional
    @Query(value = "SELECT * FROM products WHERE LOWER(product_name) LIKE LOWER(CONCAT('%', ?1, '%'))", nativeQuery = true)
    List<SemanticModel> searchProducts(String keyword);
}
