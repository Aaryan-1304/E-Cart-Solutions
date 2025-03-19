 	package com.hpcl.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.math3.stat.descriptive.summary.Product;
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
import com.hpcl.service.ProductService;

@Controller
@RequestMapping("/")  // Base request mapping
public class CartController {
	@Autowired
	private ProductService productService;
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
        @RequestParam(name = "productDescription", required = false) String productDescription,
        
        Model model, HttpSession session, RedirectAttributes rAttr) {

        try {
            Map<Integer, ProductModel> cart = (Map<Integer, ProductModel>) session.getAttribute("cart");
            if (cart == null) {
                cart = new HashMap<>();
            }
            if(cart.containsKey(productId)) {
                ProductModel existingProduct = cart.get(productId);
                existingProduct.setQuantity(existingProduct.getQuantity() + 1);
            }else {
                ProductModel product = new ProductModel(productType, productPrice, productName, productId, productImage, productDescription);
                cart.put(productId, product);
            }
            session.setAttribute("cart", cart);
        } catch (Exception e) {
            e.printStackTrace();
            return "errorPage";
        }
        return "redirect:/viewCart";
    }
    
    @PostMapping("/updateQuantity")
    public String updateQuantity(
        @RequestParam(name = "productId")Integer productId,
        @RequestParam(name = "action")String action,
        HttpSession session, RedirectAttributes rAttr) {
        try {
            Map<Integer, ProductModel> cart = (Map<Integer, ProductModel>)session.getAttribute("cart");
            if(cart == null || !cart.containsKey(productId)) {
                rAttr.addFlashAttribute("error", "Product not found in cart");
                return "redirect:/viewCart";
            }
            ProductModel product = cart.get(productId);
            
            if("increase".equals(action)) {
                product.setQuantity(product.getQuantity() + 1);
            }else {
                if(product.getQuantity()>1) {
                    product.setQuantity(product.getQuantity() - 1);
                }else {
                    cart.remove(productId);
                }
            }
            session.setAttribute("cart", cart);
        }
        catch(Exception e){
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
    
    @PostMapping("/checkout")
    public String checkout(@RequestParam List<Integer> productId, @RequestParam List<Integer> quantity, RedirectAttributes redirectAttributes) {
        boolean success = productService.updateProductQuantity(productId, quantity);
        if (success) {
            redirectAttributes.addFlashAttribute("message", "Checkout successful, stock updated.");
            return "redirect:/payment";
        } else {
            redirectAttributes.addFlashAttribute("error", "Checkout failed, insufficient stock.");
            return "redirect:/cart";
        }
    }

}




















