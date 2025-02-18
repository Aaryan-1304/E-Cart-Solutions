package com.hpcl.controller;

import java.io.PrintWriter;

import java.io.StringWriter;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.Session;

import org.apache.tomcat.util.net.openssl.ciphers.Authentication;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hpcl.model.EcartModel;
import com.hpcl.model.ProductModel;

import org.springframework.web.bind.annotation.RequestMethod;

import com.hpcl.service.ProductService;
import com.hpcl.service.UserService;

import io.micrometer.common.util.StringUtils;
import jakarta.servlet.http.HttpSession;

@Controller
public class EcartController {
	
	@Autowired
	Environment env;
	
	@Autowired
	ObjectMapper mapper;
	
	@Autowired
	private UserService userService;

    @Autowired
    private ProductService productService;
	
	private static final Logger logger = LoggerFactory.getLogger(EcartController.class);
	
	@RequestMapping("/userLogin")
	public String userLogin(@RequestParam(name = "username", required = false) String username,
	                       @RequestParam(name = "password", required = false) String password,
	                       Model model, 
	                       HttpSession session, 
	                       HttpServletRequest request, 
	                       RedirectAttributes rAttr) throws SQLException {
	    
	    // 1. Input validation
	    if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
	        model.addAttribute("error", "Username and password are required");
	        return "loginPage";
	    }
	    
	    try {
	        // 2. User verification
	        String dbPassword = userService.findByUsername(username);
	        if (StringUtils.isEmpty(dbPassword)) {
	            model.addAttribute("error", "User does not exist!");
	            return "loginPage";  // Changed from signUp to loginPage for consistency
	        }
	        
	        // 3. Password verification
	        if (!dbPassword.equals(password)) {  // Note: Should use password hashing
	            model.addAttribute("error", "Invalid credentials");
	            return "loginPage";
	        }
	        
	        // 4. Success path
	        String userRole = userService.getUserRole(username);
	        
	        // 5. Session management
	        session.setAttribute("loggedInUser", username);
	        session.setAttribute("userRole", userRole);
	        session.setMaxInactiveInterval(30*60);
	        
	        // 6. Load required data
	        List<ProductModel> expensiveProducts = productService.findTop3ExpensiveProducts();
	        model.addAttribute("topThreeProducts", expensiveProducts);
	        
	        // 7. Use redirectAttributes instead of model for redirect scenarios
	        rAttr.addFlashAttribute("message", "Login successful!");
	        return "/homepage";
	        
	    } catch (Exception e) {
	        model.addAttribute("error", "An error occurred during login");
	        logger.error("Login error for user: " + username, e);
	        return "loginPage";
	    }
	}
	
	@RequestMapping("/userSignup")
	public String userSignUp(@RequestParam(name = "username", required = false) String username,
	                         @RequestParam(name = "password", required = false) String password,
 							 @RequestParam(name = "usertype", required = false) String userType,
							 Model model, HttpSession session, HttpServletRequest request, RedirectAttributes rAttr) throws SQLException {
								String dbPassword="";
								 try {}
								 catch(Exception e) {
									 e.printStackTrace();
									 model.addAttribute("error", "An error occured while processing your request.");
									// return "signUp";
								 }
								 return "signUp"; 
							 }
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response, Model model) {
	    try {
	        HttpSession session = request.getSession(false);
	        if (session != null) {
	            // Clear all session attributes
	            Enumeration<String> attributeNames = session.getAttributeNames();
	            while (attributeNames.hasMoreElements()) {
	                session.removeAttribute(attributeNames.nextElement());
	            }
	            session.invalidate();
	        }
	        
	        // Set response headers
	        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	        response.setHeader("Pragma", "no-cache");
	        response.setDateHeader("Expires", 0);
	        
	        // Add response header to trigger client-side redirect
	        response.setHeader("X-Session-Terminated", "true");
	        
	    } catch (Exception e) {
	        logger.error("Error during logout: ", e);
	        return "redirect:/userLogin?error=true";
	    }
        return "redirect:/userLogin?sessionExpired=true";
	}
}
