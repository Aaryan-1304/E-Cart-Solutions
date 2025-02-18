package com.hpcl.service;


import com.hpcl.model.EcartModel;
import com.hpcl.repository.EcartRepository;

import java.sql.SQLException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
	
	@Autowired
	private EcartRepository ecartRepository;
	
	public String findByUsername(String username) {
	
		return ecartRepository.findByUsername(username);
	}
	public void saveUser(EcartModel user) {
	    // Implement the logic to save the user to the database
	    ecartRepository.save(user);
	}
	public void registerUser(EcartModel user) {
		// TODO Auto-generated method stub
		ecartRepository.save(user);
		//ecartRepository.registerUser(username, password, userType);
		
	}
	public class UserDTO {
	    public String getPassword() {
			return password;
		}
		public void setPassword(String password) {
			this.password = password;
		}
		public String getRole() {
			return role;
		}
		public void setRole(String role) {
			this.role = role;
		}
		private String password;
	    private String role;
	}

	public UserDTO findByUsernameWithRole(String username) throws SQLException {
		
		return null;
	}
	public String getUserRole(String username) {
		
		return ecartRepository.findUserRoleByUsername(username);
	}

}
