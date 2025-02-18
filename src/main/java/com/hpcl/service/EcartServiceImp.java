package com.hpcl.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hpcl.model.EcartModel;
import com.hpcl.repository.EcartRepository;

import EcartDetailsDTO.EcartDetailsDTO;
import jakarta.transaction.Transactional;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Optional;


@Service
public class EcartServiceImp implements IEcartService {
    @Autowired
    private EcartRepository ecartRepository;

    public EcartDetailsDTO getDetails(Integer userId) throws RuntimeException, IllegalArgumentException {
        // Initialize timestamp with current time
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(System.currentTimeMillis());
        
        // Use orElseThrow instead of manually checking for null
        EcartModel user = ecartRepository.findById(userId)
            .orElseThrow(() -> new IllegalArgumentException("User not found for ID: " + userId));
        
        EcartDetailsDTO details = new EcartDetailsDTO();
        details.setUserId(user.getUserId());
        details.setUserType(user.getUserType());
        details.setTimestamp(currentTimestamp);
        
        return details;
    }
}