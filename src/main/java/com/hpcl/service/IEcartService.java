package com.hpcl.service;

import java.util.List;

import EcartDetailsDTO.EcartDetailsDTO;

public interface IEcartService {

	EcartDetailsDTO getDetails(Integer userId) throws RuntimeException, IllegalArgumentException;
	
}
