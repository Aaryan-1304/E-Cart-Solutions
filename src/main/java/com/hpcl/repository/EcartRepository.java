package com.hpcl.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.hpcl.model.EcartModel;

import jakarta.transaction.Transactional;

@Repository
public interface EcartRepository extends JpaRepository<EcartModel, Integer> {
    
	@Modifying
    @Transactional
    @Query(value = "INSERT INTO user_Info (username, userpassword, usertype) VALUES (:username, :password, :type)", nativeQuery = true)
    void registerUser(@Param("username") String username, @Param("password") String password, @Param("type") String type);


	@Query(value = "SELECT userpassword FROM user_Info WHERE username=:username", nativeQuery = true)
    String findByUsername(@Param("username") String username);
	
	@Query(value = "SELECT userType FROM user_Info WHERE username=:username", nativeQuery = true)
    String findUserRoleByUsername(@Param("username") String username);
	
	@Query(value = "SELECT userId from user_info WHERE user_id = :userId", nativeQuery = true)
	Optional<EcartModel> findById(@Param("userId") Integer userId);
}

