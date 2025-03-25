package com.hpcl.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hpcl.model.APIModel;
import com.hpcl.repository.APIRepository;

@Service
public class APIService {
	 	@Autowired
	    private APIRepository apiRepository;
	 public List<APIModel> searchProducts(String query) {
		    List<APIModel> results = apiRepository.searchProducts(query);
		    return results != null ? results : new ArrayList<>();
		}

	 }
	
