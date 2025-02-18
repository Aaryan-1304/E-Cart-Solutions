package com.hpcl.controller;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class SessionSecurityFilter implements Filter {
    
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        HttpSession session = httpRequest.getSession(false);
        String requestURI = httpRequest.getRequestURI();

        // Only set no-cache headers for sensitive pages, not all pages
        if(requestURI.endsWith("/logout") || requestURI.contains("/secure/")) {
            httpResponse.setHeader("Cache-Control", "no-store, must-revalidate");
            httpResponse.setHeader("Pragma", "no-cache");
            httpResponse.setDateHeader("Expires", 0);
        } else {
            // For other pages, allow browser caching but require revalidation
            httpResponse.setHeader("Cache-Control", "private, must-revalidate");
        }
        
        // Allow public pages and static resources without session check
        if (isPublicResource(requestURI)) {
            chain.doFilter(request, response);
            return;
        }
        
        // Check if session exists and is valid
        if (session == null || session.getAttribute("loggedInUser") == null) {
            // Store the requested URL in session for redirect after login
            if(session != null && !requestURI.contains("/userLogin")) {
                session.setAttribute("returnUrl", requestURI);
            }
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/userLogin");
            return;
        }
        
        chain.doFilter(request, response);
    }
    
    private boolean isPublicResource(String uri) {
        return uri.endsWith("/userLogin") || 
               uri.endsWith(".css") || 
               uri.endsWith(".js") || 
               uri.endsWith(".ico") ||
               uri.endsWith(".png") ||
               uri.endsWith(".jpg") ||
               uri.endsWith(".gif") ||
               uri.contains("/api/") ||
               uri.endsWith("/userSignup") ||
               uri.endsWith("/perform_login") ||
               uri.contains("/assets/") ||  // Add this if you have an assets folder
               uri.endsWith("/error");
    }
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}
    
    @Override
    public void destroy() {}
}