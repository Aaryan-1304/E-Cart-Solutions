<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - E-Cart Solutions</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        /* Header Styles */
        .header {
            background: #28a745;
            color: white;
            padding: 1rem 0;
            width: 100%;
        }

        .header .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 90%;
            margin: auto;
        }

        .header .logo {
            font-size: 2rem;
            font-weight: bold;
            text-decoration: none;
            color: white;
        }

        .header .navbar {
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .header .nav {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 1.5rem;
        }

        .header .nav li {
            margin: 0;
        }

        .header .nav a {
            color: white;
            text-decoration: none;
            font-size: 1rem;
            padding: 5px 10px;
            border-radius: 5px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .header .nav a:hover {
            background-color: rgba(255, 255, 255, 0.2);
            transform: scale(1.05);
        }

        .user-section {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .user-name {
            color: white;
            font-size: 1rem;
            font-weight: bold;
        }

        .sign-out {
            color: white;
            text-decoration: none;
            background-color: rgba(255, 255, 255, 0.2);
            padding: 5px 10px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .sign-out:hover {
            background-color: rgba(255, 255, 255, 0.4);
        }

        /* Payment Section Styles */
        .payment-section {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .payment-title {
            color: #28a745;
            text-align: center;
            margin-bottom: 2rem;
            font-size: 2rem;
        }

        .payment-option {
            display: block;
            width: 100%;
            padding: 1rem;
            margin: 1rem 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-align: center;
            text-decoration: none;
            color: #333;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .payment-option:hover {
            background-color: #f8f9fa;
            transform: translateY(-2px);
        }

        .proceed-button {
            background: #28a745;
            color: white;
            border: none;
            padding: 1rem;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1rem;
            margin-top: 1rem;
            transition: background-color 0.3s ease;
        }

        .proceed-button:hover {
            background: #218838;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 1rem;
            color: #28a745;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .footer {
            background: #333;
            color: white;
            text-align: center;
            padding: 1rem 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        .payment-form {
            display: none;
            margin-top: 1rem;
            padding: 1rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            background: #f8f9fa;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #333;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
        }

        .form-row {
            display: flex;
            gap: 1rem;
        }

        .form-row .form-group {
            flex: 1;
        }

        .active-option {
            background-color: #e8f5e9 !important;
            border-color: #28a745 !important;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }

        .modal-content {
            position: relative;
            background-color: white;
            margin: 15% auto;
            padding: 2rem;
            width: 80%;
            max-width: 500px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .close-button {
            position: absolute;
            right: 1rem;
            top: 1rem;
            font-size: 1.5rem;
            cursor: pointer;
            color: #666;
        }

        .close-button:hover {
            color: #333;
        }

        .submit-button {
            background: #28a745;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
            margin-top: 1rem;
        }

        .submit-button:hover {
            background: #218838;
        }

        /* Bank List Styles */
        .bank-list {
            max-height: 200px;
            overflow-y: auto;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-top: 1rem;
        }

        .bank-option {
            padding: 0.75rem;
            cursor: pointer;
            border-bottom: 1px solid #eee;
        }

        .bank-option:hover {
            background-color: #f0f0f0;
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="container">
            <a href="/eCart/homepage" class="logo">E-Cart Solutions</a>
            
            <nav class="navbar">
                <ul class="nav">
                    <li><a href="/eCart/homepage">Home</a></li>
                    <li><a href="/eCart/allProducts">Shop</a></li>
                    <li><a href="/eCart/about">About</a></li>
                    <li><a href="/eCart/contact">Contact</a></li>
                    <li><a href="#"><i class="fas fa-search"></i></a></li>
                    <li><a href="${pageContext.request.contextPath}/viewCart">
                        <i class="fas fa-shopping-cart"></i> Cart
                    </a></li>
                </ul>
            </nav>

            <div class="user-section">
                <span class="user-name">Welcome, ${sessionScope.loggedInUser}!</span>
                <a href="${pageContext.request.contextPath}/logout" class="sign-out">Sign Out</a>
            </div>
        </div>
    </header>

    <div class="payment-section">
    <h1 class="payment-title">Select Payment Method</h1>
    
    <button class="payment-option" onclick="showPaymentForm('card-form')">💳 Credit/Debit Card</button>
    <div id="card-form" class="payment-form">
        <form onsubmit="return handlePayment(event)">
            <div class="form-group">
                <label for="card-number">Card Number</label>
                <input type="text" id="card-number" maxlength="16" placeholder="1234 5678 9012 3456" required>
            </div>
            <div class="form-group">
                <label for="card-name">Cardholder Name</label>
                <input type="text" id="card-name" placeholder="John Doe" required>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="expiry">Expiry Date</label>
                    <input type="text" id="expiry" placeholder="MM/YY" maxlength="5" required>
                </div>
                <div class="form-group">
                    <label for="cvv">CVV</label>
                    <input type="password" id="cvv" maxlength="3" placeholder="123" required>
                </div>
            </div>
            <button type="submit" class="submit-button">Pay Now</button>
        </form>
    </div>

    <!-- Net Banking Section -->
    <button class="payment-option" onclick="showPaymentForm('netbanking-form')">🏦 Net Banking</button>
    <div id="netbanking-form" class="payment-form">
        <form onsubmit="return handlePayment(event)">
            <div class="form-group">
                <label for="bank-name">Bank Name</label>
                <input type="text" id="bank-name" placeholder="Enter bank name" required>
            </div>
            <div class="form-group">
                <label for="account-number">Account Number</label>
                <input type="text" id="account-number" placeholder="Enter account number" required>
            </div>
            <div class="form-group">
                <label for="ifsc">IFSC Code</label>
                <input type="text" id="ifsc" placeholder="Enter IFSC code" required>
            </div>
            <div class="form-group">
                <label for="branch">Branch</label>
                <input type="text" id="branch" placeholder="Enter branch name" required>
            </div>
            <button type="submit" class="submit-button">Proceed</button>
        </form>
    </div>

    <!-- Bank Transfer Section -->
    <button class="payment-option" onclick="showPaymentForm('bank-transfer-form')">↔️ Bank Transfer</button>
    <div id="bank-transfer-form" class="payment-form">
        <form onsubmit="return handlePayment(event)">
            <div class="form-group">
                <label for="transfer-account">Account Number</label>
                <input type="text" id="transfer-account" placeholder="Enter account number" required>
            </div>
            <div class="form-group">
                <label for="transfer-ifsc">IFSC Code</label>
                <input type="text" id="transfer-ifsc" placeholder="Enter IFSC code" required>
            </div>
            <div class="form-group">
                <label for="transfer-name">Account Holder Name</label>
                <input type="text" id="transfer-name" placeholder="Enter account holder name" required>
            </div>
            <button type="submit" class="submit-button">Transfer</button>
        </form>
    </div>

    <!-- UPI Section -->
    <button class="payment-option" onclick="showPaymentForm('upi-form')">📱 UPI</button>
    <div id="upi-form" class="payment-form">
        <form onsubmit="return handlePayment(event)">
            <div class="form-group">
                <label for="upi-id">UPI ID</label>
                <input type="text" id="upi-id" placeholder="username@upi" required>
            </div>
            <button type="submit" class="submit-button" >Pay via UPI</button>
        </form>
    </div>

    <a href="${pageContext.request.contextPath}/viewCart" class="back-link">← Back to Cart</a>
</div>

<footer class="footer">
    <p>&copy; 2025 E-Cart Solutions. All rights reserved.</p>
</footer>

<script>
    function showPaymentForm(formId) {
        const forms = document.querySelectorAll('.payment-form');
        forms.forEach(form => form.style.display = 'none');

        const options = document.querySelectorAll('.payment-option');
        options.forEach(option => option.classList.remove('active-option'));

        const selectedForm = document.getElementById(formId);
        selectedForm.style.display = 'block';
        const selectedOption = selectedForm.previousElementSibling;
        selectedOption.classList.add('active-option');
    }

    function handlePayment(event) {
        event.preventDefault();
        alert('Payment processing... This is a demo.');
        return false;
    }

    document.getElementById('card-number').addEventListener('input', function(e) {
        let value = e.target.value.replace(/\D/g, '');
        e.target.value = value;
    });

    document.getElementById('expiry').addEventListener('input', function(e) {
        let value = e.target.value.replace(/\D/g, '');
        if (value.length > 2) {
            value = value.slice(0, 2) + '/' + value.slice(2);
        }
        e.target.value = value;
    });

    document.getElementById('cvv').addEventListener('input', function(e) {
        let value = e.target.value.replace(/\D/g, '');
        e.target.value = value;
    });
</script>
</body>
</html>