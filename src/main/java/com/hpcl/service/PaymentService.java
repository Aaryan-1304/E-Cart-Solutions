//package com.hpcl.service;
//
//import com.razorpay.Order;
//import com.razorpay.RazorpayClient;
//import org.json.JSONObject;
//import org.springframework.stereotype.Service;
//
//@Service
//public class PaymentService{
//	private static final String KEY_ID = "";
//	private static final String KEY_SECRET = "";
//	
//	public String createOrder(int amount) {
//		try {
//			RazorpayClient Client = new RazorpayClient(KEY_ID, KEY_SECRET);
//			
//			JSONObject orderRequest = new JSONObject();
//			orderRequest.put("amount", amount*100);
//			orderRequest.put("currency", "INR");
//			orderRequest.put("receipt", "txn_123");
//			
//			
//			Order order = client.orders.create(orderRequest);
//			return order.toString();
//		}catch(Exception e) {
//			e.printStackTrace();
//			return "";
//		}
//		return "";
//	}
//}