package com.hpcl.controller;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hpcl.model.ProductModel;
import com.hpcl.service.ProductService;


@Controller
public class HomepageController {
    private static final Logger logger = LoggerFactory.getLogger(HomepageController.class);

    @Autowired
    private ProductService productService;

    @RequestMapping({ "/allProducts" })
    public String getAllProducts(Model model, HttpSession session,
                                 HttpServletRequest request, RedirectAttributes rAttr) {
        try {
        	List<ProductModel> productModelList =  null;    
        		productModelList = productService.findAllProducts();
	            if (productModelList == null || productModelList.isEmpty()) {
	                model.addAttribute("message", "No products available.");
	            } 
	            model.addAttribute("productsList", productModelList);
            
        } catch (Exception e) {
	            logger.error("Error in getAllProducts method:", e);
	            model.addAttribute("error", "Unable to fetch products at this time. Please try again later.");
	        }
        return "displayProducts";
    }
    @RequestMapping("/addItems")
    public String addProduct(@RequestParam(name = "productName", required = false) String productName,
                             @RequestParam(name = "productType", required = false) String productType,
                             @RequestParam(name = "productPrice", required = false) String productPrice, 
                             Model model) {
        try {
            if ((productName != null && !productName.isEmpty()) &&
                (productPrice != null && !productPrice.isEmpty()) &&
                (productType != null && !productType.isEmpty())) {
            	
                ProductModel newProduct = new ProductModel();
                newProduct.setProductName(productName);
                newProduct.setProductPrice(productPrice);
                newProduct.setProductType(productType);
                
                ProductModel newProductOnInsert = productService.saveProduct(newProduct);
                if (newProductOnInsert != null) {
                    model.addAttribute("message", "Product added successfully");
                } else {
                    model.addAttribute("error", "Failed to add product.");	
                }
            } else {
                model.addAttribute("error", "All fields are required.");
            }
        } catch (Exception e) {
            logger.error("Error adding product: ", e);
            model.addAttribute("error", "Error adding product: " + e.getMessage());
        }       
        return "homepage";
    }
    @RequestMapping("/searchProducts")
    public String searchProducts(@RequestParam(value = "searchInput", required = false) String searchInput, Model model) {
        System.out.println(" Received search request for query: " + searchInput); // Debugging

        try {
            if (searchInput == null || searchInput.trim().isEmpty()) {
                System.out.println("Search Input is empty");
                model.addAttribute("searchResults", new ArrayList<>());
                model.addAttribute("searchMessage", "Please enter a search input.");
            } else {
                System.out.println("Calling productService.searchProduct()...");
                List<ProductModel> searchResults = productService.searchProduct(searchInput);
                System.out.println("Search results size: " + searchResults.size()); // Debugging

                model.addAttribute("searchResults", searchResults);
                model.addAttribute("searchedInput", searchInput);

                if (searchResults.isEmpty()) {
                    model.addAttribute("searchMessage", "No products found matching your search.");
                }
            }
            
            return "homepage";
     
        } catch (Exception e) {
            System.err.println("Error in search: " + e.getMessage());
            e.printStackTrace();
            
            model.addAttribute("errorMessage", "An error occurred while searching. Please try again.");
            return "errorPage";
        }
    }
        @RequestMapping("/")
        public String home(Model model) {
            return "homepage";
        }
    
    @GetMapping("/expensiveProducts")
    @PostMapping("/expensiveProducts")
    public String expensiveProduct(Model model) {
        try {
            List<ProductModel> topThreeProducts = productService.findTop3ExpensiveProducts();
            
            if(topThreeProducts.isEmpty()) {
                model.addAttribute("message", "No featured products available at this time.");
            } else {
                model.addAttribute("topThreeProducts", topThreeProducts);
                model.addAttribute("message", "Showing top featured products");
            }
        } catch (Exception e) {
            model.addAttribute("error", "Unable to fetch top products at this time");
        }
        return "homepage";
    }

    @GetMapping("/removeItemsPage")
    public String removeProduct(@RequestParam(name = "productName", required = false) String productName,
                                 Model model, RedirectAttributes redirectAttributes) {
        try {
            if (productName == null || productName.isEmpty()) {
                model.addAttribute("error", "Product name is required for removal.");
                return "removeItemsPage";
            }

            int productRemoved = productService.removeProduct(productName);
            if (productRemoved > 0) {
                model.addAttribute("message", "Product removed successfully");
            } else {
                model.addAttribute("error", "Product not found or could not be removed.");
            }

            List<ProductModel> productModelList = productService.findAllProducts();
            model.addAttribute("productsList", productModelList);
        } catch (Exception e) {
            logger.error("Error removing product: ", e);
            redirectAttributes.addFlashAttribute("error", "Error removing product: " + e.getMessage());
        }
        return "removeItemsPage";
    }
    @RequestMapping("/homepage")
    public String homepage(Model model) {
        try {
        	List<ProductModel> topThreeProducts = productService.findTop3ExpensiveProducts();
            model.addAttribute("topThreeProducts", topThreeProducts);
            
            if(topThreeProducts.isEmpty()) {
                model.addAttribute("message", "No featured products available at this time.");
            }
        } catch (Exception e) {
            model.addAttribute("error", "Unable to fetch top products at this time");
        }
        return "homepage";
    }
    @RequestMapping("/about")
    public String about() {
        return "about";  
    }
    
    @RequestMapping("/contact")
    public String contact() {
        return "contact"	;
    }
    
    @PostMapping("/updateProduct")
    public String updateProduct(@ModelAttribute ProductModel product, RedirectAttributes redirectAttributes) {
        productService.updateProduct(product); 
        redirectAttributes.addFlashAttribute("message", "Product updated successfully!");
        return "redirect:/allProducts"; // Redirect after updating
    }

    @GetMapping("/updateItems")
    public String showUpdateItems(@RequestParam("productId") Integer productId,
                                  @RequestParam("productName") String productName,
                                  @RequestParam("productType") String productType,
                                  @RequestParam("productPrice") String productPrice,
                                  @RequestParam("productImage") String productImage,
                                  Model model) {
        
        ProductModel product = new ProductModel();
        product.setProductId(productId);
        product.setProductName(productName);
        product.setProductType(productType);
        product.setProductPrice(productPrice);
        product.setProductImage(productImage);

        model.addAttribute("product", product);

        List<String> productTypes = Arrays.asList("Electronics", "Clothing", "Accessories", "Toys", 
                "Books", "Footwear", "Home Appliances", "Groceries");
        model.addAttribute("productTypes", productTypes);

        return "updateItems";
    }
    
    @GetMapping("/form")
    public String showForm(Model model) {
        List<String> productTypes = List.of(
            "Electronics", "Clothing", "Accessories", "Toys", 
            "Books", "Footwear", "Home Appliances", "Groceries"
        );
        model.addAttribute("productTypes", productTypes);

        ProductModel product = new ProductModel();
        product.setProductType("");  
        model.addAttribute("product", product);

        return "form";
    }
}