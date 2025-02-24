package com.hpcl.controller;

import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hpcl.model.ProductModel;

@Controller
@RequestMapping("/")  // Base request mapping
public class CartController {
    
    @Autowired
    Environment env;
    
    @Autowired
    ObjectMapper mapper;
    
    // Mapping for viewing the cart
    @GetMapping(value = {"/viewCart", "/cart"})
    public String viewCart(Model model, HttpSession session) {
        try {
            Map<String, ProductModel> cart = (Map<String, ProductModel>) session.getAttribute("cart");
            if (cart == null) {
                cart = new HashMap<>();
                session.setAttribute("cart", cart);  // Ensure session gets updated
            }
            model.addAttribute("cart", cart.values());
            return "cart"; 
        } catch (Exception e) {
            e.printStackTrace();
            return "errorPage";
        }
    }
    
    @PostMapping("/addToCart")
    public String addToCart(
        @RequestParam(name = "productId", required = false) Integer productId,
        @RequestParam(name = "productName", required = false) String productName,
        @RequestParam(name = "productType", required = false) String productType,
        @RequestParam(name = "productPrice", required = false) String productPrice,
        @RequestParam(name = "productImage", required = false) String productImage,

        
        Model model, HttpSession session, RedirectAttributes rAttr) {

        try {
            Map<Integer, ProductModel> cart = (Map<Integer, ProductModel>) session.getAttribute("cart");
            if (cart == null) {
                cart = new HashMap<>();
            }
            ProductModel product = new ProductModel(productType, productPrice, productName, productId, productImage);
            cart.put(productId, product);
            session.setAttribute("cart", cart);
        } catch (Exception e) {
            e.printStackTrace();
            return "errorPage";
        }
        return "redirect:/viewCart";
    }
    @PostMapping("/removeFromCart")
    public String removeFromCart(@RequestParam(name = "productId", required = false) String productId,
                                 Model model, HttpSession session, RedirectAttributes rAttr) {
        try {
            Map<Integer, ProductModel> cart = (Map<Integer, ProductModel>) session.getAttribute("cart");
            
            if (cart != null && !cart.isEmpty()) {
                Integer id = Integer.parseInt(productId);
                if (cart.containsKey(id)) {
                    cart.remove(id);
                    session.setAttribute("cart", cart);
                    rAttr.addFlashAttribute("message", "Product removed successfully");
                } else {
                    rAttr.addFlashAttribute("error", "Product not found in cart");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "errorPage";
        }
        return "redirect:/viewCart";
    }
    
    @GetMapping("/payment")
    public String paymentPage() {
    	return "payment";
    }

}
