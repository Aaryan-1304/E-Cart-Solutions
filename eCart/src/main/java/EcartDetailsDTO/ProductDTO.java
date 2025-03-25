package EcartDetailsDTO;

public class ProductDTO {
    private Integer id;
    private String name;
    private String price;
    private String imageBase64;
    
    // Default constructor
    public ProductDTO() {
    }
    
    // Getters and setters with the exact method names your code is using
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getPrice() {
        return price;
    }
    
    public void setPrice(String price) {
        this.price = price;
    }
    
    public String getImageBase64() {
        return imageBase64;
    }
    
    public void setImageBase64(String imageBase64) {
        this.imageBase64 = imageBase64;
    }
}