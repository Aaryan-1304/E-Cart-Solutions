package com.hpcl.controller;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.URI;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.collections4.map.MultiValueMap;
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
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponentsBuilder;

import com.ctc.wstx.shaded.msv_core.datatype.xsd.datetime.TimeZone;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.MapperFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.hpcl.model.ProductModel;
import com.hpcl.model.ProductModelList;
import com.hpcl.service.ProductService;


@Controller
public class HomepageController {
    private static final Logger logger = LoggerFactory.getLogger(HomepageController.class);
    @Autowired
    Environment env;
    
    @Autowired
    private ProductService productService;
    
    private RestTemplate restTemplate = new RestTemplate();

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
//    @RequestMapping("/searchProducts")
//    public String searchProducts(@RequestParam(value = "searchInput", required = false) String searchInput, Model model) {
//        System.out.println("Received search request for query: " + searchInput);
//
//        RestTemplate restTemplate = new RestTemplate();
//        ObjectMapper mapper = new ObjectMapper();
//        String apiUrl = env.getProperty("API.URL") + "/searchProducts/searchInput/" + searchInput;
//        try {
//            if (searchInput == null || searchInput.trim().isEmpty()) {
//                model.addAttribute("searchMessage", "Please enter a search input.");
//                model.addAttribute("searchResults", new ArrayList<>());
//                return "homepage";  // Return the same JSP page
//            }
//
//            System.out.println("API URL: " + apiUrl);
//            String responseJson = restTemplate.getForObject(apiUrl, String.class);
//            System.out.println("API Response JSON: " + responseJson);
//
//            if (responseJson != null && !responseJson.isEmpty()) {
//                // Deserialize JSON to List<ProductModel>
//                List<ProductModel> searchResults = mapper.readValue(responseJson,
//                        mapper.getTypeFactory().constructCollectionType(List.class, ProductModel.class));
//
//                model.addAttribute("searchResults", searchResults);
//                model.addAttribute("searchedInput", searchInput);
//
//                if (searchResults.isEmpty()) {
//                    model.addAttribute("searchMessage", "No products found matching your search.");
//                }
//            } else {
//                model.addAttribute("searchMessage", "No products found.");
//            }
//        } catch (Exception e) {
//            System.err.println("Error during API call: " + e.getMessage());
//            e.printStackTrace();
//            model.addAttribute("searchMessage", "An error occurred while searching. Please try again.");
//        }
//
//        return "homepage";  
//    }
//    @RequestMapping("/semanticSearch")
    @GetMapping(value = "/search")
    public String searchProducts(@RequestParam("query") String searchInput, Model model) {
        try {
            // Correct URL construction
            String apiUrl = env.getProperty("python.service.url") + "?query=" + URLEncoder.encode(searchInput, StandardCharsets.UTF_8);
            System.out.println("Constructed API URL: " + apiUrl);

            // Make the API call to Python service to get matching product IDs
            String[] productIds = restTemplate.getForEntity(apiUrl, String[].class).getBody();

            if (productIds != null && productIds.length > 0) {
                // Convert String IDs to Integer and fetch products
                List<Integer> productIdList = Arrays.stream(productIds)
                        .map(Integer::parseInt)
                        .collect(Collectors.toList());
                
                List<ProductModel> searchResults = productService.findProductsByIds(productIdList);

                model.addAttribute("searchResults", searchResults);
                model.addAttribute("searchedInput", searchInput);

                if (searchResults.isEmpty()) {
                    model.addAttribute("searchMessage", "No products found matching your search.");
                }
            } else {
                model.addAttribute("searchMessage", "No products found.");
            }
        } catch (Exception e) {
            // Print full stack trace for debugging
            e.printStackTrace();
            
            // Add a user-friendly error message
            model.addAttribute("searchMessage", "An error occurred while searching. Please try again.");
        }

        return "homepage";
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
    
    private ObjectMapper getObjectMapper() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault());
        ObjectMapper objMapper = JsonMapper.builder().enable(MapperFeature.ACCEPT_CASE_INSENSITIVE_PROPERTIES)
            .defaultTimeZone(java.util.TimeZone.getDefault()).disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
            .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)
            .configure(DeserializationFeature.FAIL_ON_MISSING_CREATOR_PROPERTIES, false)
            .configure(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT, true)
            .serializationInclusion(Include.NON_NULL).defaultDateFormat(new SimpleDateFormat("yyyy-MM-dd")).build();
        objMapper.setDateFormat(sdf);
        return objMapper;
    }
  private ObjectMapper setObjectMapperProperties() {
	  ObjectMapper objMapper = new ObjectMapper();
        objMapper = JsonMapper.builder().enable(MapperFeature.ACCEPT_CASE_INSENSITIVE_PROPERTIES)
                    .disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
                    .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)
                    .configure(DeserializationFeature.FAIL_ON_MISSING_CREATOR_PROPERTIES, false)
                    .configure(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT, true)
                    .serializationInclusion(Include.NON_NULL).build();
        return objMapper;
  }
}