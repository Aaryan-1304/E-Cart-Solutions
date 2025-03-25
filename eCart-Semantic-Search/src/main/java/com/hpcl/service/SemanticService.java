package com.hpcl.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.hpcl.model.SemanticModel;

@Service
public class SemanticService {

    @Autowired
    private RestTemplate restTemplate;

    public List<SemanticModel> semanticSearch(String searchInput) {
        String apiUrl = "http://localhost:9090/semanticSearch?query=" + searchInput;
        try {
            ResponseEntity<SemanticModel[]> response = restTemplate.getForEntity(apiUrl, SemanticModel[].class);
            return Arrays.asList(response.getBody());
        } catch (Exception e) {
            System.err.println("Error during semantic search: " + e.getMessage());
            return new ArrayList<>();
        }
    }
}
