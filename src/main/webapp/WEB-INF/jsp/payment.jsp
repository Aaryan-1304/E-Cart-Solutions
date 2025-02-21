<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        .payment-navbar {
            background-color: #2d8f29;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 15px 0;
            font-size: 1.5rem;
            font-weight: bold;
        }

        .container {
            max-width: 500px;
            margin: auto;
            padding: 2rem;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-top: 2rem;
        }

        .payment-header {
            text-align: center;
            color: #28a745;
            font-size: 2rem;
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        label {
            font-size: 1rem;
            font-weight: bold;
            color: #333;
            display: block;
            margin-bottom: 5px;
        }

        input, select {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .btn {
            width: 100%;
            padding: 12px;
            font-size: 1rem;
            font-weight: bold;
            color: white;
            background-color: #28a745;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
            margin-top: 10px;
        }

        .btn:hover {
            background-color: #218838;
        }

        .footer {
            background: #333;
            color: white;
            text-align: center;
            padding: 1rem 0;
            margin-top: 2rem;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 1rem;
            font-size: 1rem;
            color: #28a745;
            text-decoration: none;
            font-weight: bold;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .payment-options {
            margin-bottom: 1rem;
        }

        .payment-option {
            display: block;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            cursor: pointer;
            margin-bottom: 10px;
            background: #fff;
            text-align: center;
            font-weight: bold;
        }

        .payment-option:hover {
            background-color: #f1f1f1;
        }

        .payment-details {
            display: none;
            margin-top: 1rem;
        }
    </style>
</head>
<body>

<%@include file="header.jsp"%>
<div class="payment-navbar">
    Payment
</div>

<div class="container">
    <h2 class="payment-header">Select Payment Method</h2>
    
    <form action="${contextPath}/processPayment" method="POST">

        <div class="payment-options">
            <label class="payment-option" onclick="showPaymentDetails('card')">
                <i class="fas fa-credit-card"></i> Credit/Debit Card
            </label>
            <label class="payment-option" onclick="showPaymentDetails('netbanking')">
                <i class="fas fa-university"></i> Net Banking
            </label>
            <label class="payment-option" onclick="showPaymentDetails('banktransfer')">
                <i class="fas fa-exchange-alt"></i> Bank Transfer
            </label>
            <label class="payment-option" onclick="showPaymentDet	ails('upi')">
                <i class="fas fa-qrcode"></i> UPI
            </label>
        </div>

        <div id="card" class="payment-details">
            <div class="form-group">
                <label for="card-number">Card Number</label>
                <input type="text" id="card-number" name="cardNumber" maxlength="16">
            </div>
            <div class="form-group">
                <label for="expiry-date">Expiry Date</label>
                <input type="month" id="expiry-date" name="expiryDate">
            </div>
            <div class="form-group">
                <label for="cvv">CVV</label>
                <input type="password" id="cvv" name="cvv" maxlength="3">
            </div>
        </div>

        <div id="netbanking" class="payment-details">
            <div class="form-group">
                <label for="bank">Select Bank</label>
                <select id="bank" name="bank">
                    <option value="">Select Bank</option>
                    <option value="SBI">State Bank of India</option>
                    <option value="HDFC">HDFC Bank</option>
                    <option value="ICICI">ICICI Bank</option>
                    <option value="AXIS">Axis Bank</option>
                </select>
            </div>
        </div>

       
        <div id="banktransfer" class="payment-details">
            <div class="form-group">
                <label for="account-number">Account Number</label>
                <input type="text" id="account-number" name="accountNumber">
            </div>
            <div class="form-group">
                <label for="ifsc">IFSC Code</label>
                <input type="text" id="ifsc" name="ifsc">
            </div>
        </div>

        <div id="upi" class="payment-details">
            <div class="form-group">
                <label for="upi-id">UPI ID</label>
                <input type="text" id="upi-id" name="upiId">
            </div>
        </div>

        <button type="submit" class="btn">Proceed to Pay</button>
    </form>

    <a href="${contextPath}/viewCart" class="back-link">
        <i class="fas fa-arrow-left"></i> Back to Cart
    </a>
</div>

<div class="footer">
    &copy; 2025 E-Cart Solutions. All rights reserved.
</div>
<script>
    function showPaymentDetails(paymentMethod) {
        let paymentOptions = ["card", "netbanking", "banktransfer", "upi"];
        paymentOptions.forEach(option => {
            document.getElementById(option).style.display = (option === paymentMethod) ? "block" : "none";
        });
    }
</script>

</body>
</html>