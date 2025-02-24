<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - E-Cart Solutions</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            line-height: 1.6;
        }

        .about-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .about-header {
            text-align: center;
            margin-bottom: 3rem;
            color: #28a745;
        }

        .about-header h1 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .about-header p {
            font-size: 1.2rem;
            color: #666;
        }

        .about-section {
            background: white;
            border-radius: 10px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .about-section h2 {
            color: #28a745;
            margin-bottom: 1rem;
            font-size: 1.8rem;
        }

        .about-section p {
            color: #444;
            margin-bottom: 1rem;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .feature-card {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            text-align: center;
        }

        .feature-card i {
            font-size: 2.5rem;
            color: #28a745;
            margin-bottom: 1rem;
        }

        .feature-card h3 {
            color: #333;
            margin-bottom: 0.5rem;
        }

        .feature-card p {
            color: #666;
            font-size: 0.9rem;
        }

        .team-section {
            text-align: center;
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .team-member {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
        }

        .team-member img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin-bottom: 1rem;
            object-fit: cover;
        }

        .contact-info {
            text-align: center;
            margin-top: 2rem;
        }

        .contact-info a {
            color: #28a745;
            text-decoration: none;
            margin: 0 1rem;
        }

        .contact-info a:hover {
            text-decoration: underline;
        }

        .footer {
            background: #333;
            color: white;
            text-align: center;
            padding: 1rem 0;
            margin-top: 2rem;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp"%>

    <div class="about-container">
        <div class="about-header">
            <h1>About E-Cart Solutions</h1>
            <p>Your trusted partner for online shopping since 2025</p>
        </div>

        <div class="about-section">
            <h2>Our Story</h2>
            <p>E-Cart Solutions was founded with a simple mission: to make online shopping accessible, convenient, and enjoyable for everyone. What started as a small startup has grown into a trusted e-commerce platform serving thousands of satisfied customers.</p>
            <p>We believe in providing quality products at competitive prices while maintaining the highest standards of customer service. Our platform is designed to offer a seamless shopping experience, from browsing to checkout.</p>
        </div>

        <div class="about-section">
            <h2>Why Choose Us?</h2>
            <div class="features-grid">
                <div class="feature-card">
                    <i class="fas fa-truck"></i>
                    <h3>Fast Delivery</h3>
                    <p>Quick and reliable shipping to your doorstep</p>
                </div>
                <div class="feature-card">
                    <i class="fas fa-shield-alt"></i>
                    <h3>Secure Shopping</h3>
                    <p>Your security is our top priority</p>
                </div>
                <div class="feature-card">
                    <i class="fas fa-headset"></i>
                    <h3>24/7 Support</h3>
                    <p>Always here to help you</p>
                </div>
                <div class="feature-card">
                    <i class="fas fa-undo"></i>
                    <h3>Easy Returns</h3>
                    <p>Hassle-free return policy</p>
                </div>
            </div>
        </div>

        <div class="about-section team-section">
            <h2>Our Values</h2>
            <div class="team-grid">
                <div class="team-member">
                    <i class="fas fa-heart fa-3x" style="color: #28a745;"></i>
                    <h3>Customer First</h3>
                    <p>We prioritize customer satisfaction above all</p>
                </div>
                <div class="team-member">
                    <i class="fas fa-check-circle fa-3x" style="color: #28a745;"></i>
                    <h3>Quality Assured</h3>
                    <p>We guarantee the quality of our products</p>
                </div>
                <div class="team-member">
                    <i class="fas fa-users fa-3x" style="color: #28a745;"></i>
                    <h3>Community Driven</h3>
                    <p>Building lasting relationships with our customers</p>
                </div>
            </div>
        </div>

        <div class="about-section">
            <h2>Contact Us</h2>
            <div class="contact-info">
                <p>Have questions? We're here to help!</p>
                <a href="mailto:support@ecart.com"><i class="fas fa-envelope"></i> support@ecart.com</a>
                <a href="tel:+1234567890"><i class="fas fa-phone"></i> +123 456 7890</a>
            </div>
        </div>
    </div>

    <footer class="footer">
        <p>&copy; 2025 E-Cart Solutions. All rights reserved.</p>
    </footer>
</body>
</html>