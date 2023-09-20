package app.model;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import javax.persistence.Transient;
import java.time.LocalDate;
import java.util.List;


public class Product {

    private int id;
    private String product_item_id;
    private String productName;
    private int category;
    private double price;
    private byte product_status;
    private int user_id;
    private String contact_info_for_product;
    private String product_image_path;
    @Transient
    private MultipartFile multipartFile;
    private boolean locked;
    private LocalDate created_date;

    public boolean isLocked() {
        return locked;
    }

    public void setLocked(boolean locked) {
        this.locked = locked;
    }

    public LocalDate getCreated_date() {
        return created_date;
    }

    public void setCreated_date(LocalDate created_date) {
        this.created_date = created_date;
    }

    public Product(int id, String product_item_id, String productName, int category, double price, byte product_status, int user_id, String contact_info_for_product, String product_image_path, MultipartFile multipartFile, boolean locked, LocalDate created_date) {
        this.id = id;
        this.product_item_id = product_item_id;
        this.productName = productName;
        this.category = category;
        this.price = price;
        this.product_status = product_status;
        this.user_id = user_id;
        this.contact_info_for_product = contact_info_for_product;
        this.product_image_path = product_image_path;
        this.multipartFile = multipartFile;
        this.locked = locked;
        this.created_date = created_date;
    }





    public Product(int id, String product_item_id, String productName, int category, double price, byte product_status, int user_id, String contact_info_for_product, String product_image_path, MultipartFile multipartFile, boolean locked) {
        this.id = id;
        this.product_item_id = product_item_id;
        this.productName = productName;
        this.category = category;
        this.price = price;
        this.product_status = product_status;
        this.user_id = user_id;
        this.contact_info_for_product = contact_info_for_product;
        this.product_image_path = product_image_path;
        this.multipartFile = multipartFile;
        this.locked = locked;
    }

    public Product() {
    }

    public Product(String product_item_id, String productName, double price, int category) {
        this.product_item_id = product_item_id;
        this.productName = productName;
        this.category = category;
        this.price = price;
    }

    public Product(String productName, int category, double price, byte product_status, int user_id, String contact_info_for_product, String product_image_path) {
        this.productName = productName;
        this.category = category;
        this.price = price;
        this.product_status = product_status;
        this.user_id = user_id;
        this.contact_info_for_product = contact_info_for_product;
        this.product_image_path = product_image_path;
    }

    public Product(String productName, int category, double price, byte product_status, int user_id, String contact_info_for_product, String product_image_path, MultipartFile multipartFile) {
        this.productName = productName;
        this.category = category;
        this.price = price;
        this.product_status = product_status;
        this.user_id = user_id;
        this.contact_info_for_product = contact_info_for_product;
        this.product_image_path = product_image_path;
        this.multipartFile = multipartFile;
    }

    public Product(int id, String product_item_id, String productName, int category, double price, byte product_status, int user_id, String contact_info_for_product, String product_image_path, MultipartFile multipartFile) {
        this.id = id;
        this.product_item_id = product_item_id;
        this.productName = productName;
        this.category = category;
        this.price = price;
        this.product_status = product_status;
        this.user_id = user_id;
        this.contact_info_for_product = contact_info_for_product;
        this.product_image_path = product_image_path;
        this.multipartFile = multipartFile;
    }

    public Product(String product_item_id, String productName, int category, double price, byte product_status, int user_id, String contact_info_for_product, String product_image_path, MultipartFile multipartFile) {
        this.product_item_id = product_item_id;
        this.productName = productName;
        this.category = category;
        this.price = price;
        this.product_status = product_status;
        this.user_id = user_id;
        this.contact_info_for_product = contact_info_for_product;
        this.product_image_path = product_image_path;
        this.multipartFile = multipartFile;
    }

    public Product(int id, String product_item_id, String productName, int category, double price, byte product_status, int user_id, String contact_info_for_product) {
        this.id = id;
        this.product_item_id = product_item_id;
        this.productName = productName;
        this.category = category;
        this.price = price;
        this.product_status = product_status;
        this.user_id = user_id;
        this.contact_info_for_product = contact_info_for_product;
    }

    public Product(String product_item_id, String productName, int category, double price, byte product_status, int user_id) {
        this.product_item_id = product_item_id;
        this.productName = productName;
        this.category = category;
        this.price = price;
        this.product_status = product_status;
        this.user_id = user_id;
    }

    public Product(String productName, int category) {
        this.productName = productName;
        this.category = category;
    }

    public Product(String productName, int category, double price, byte product_status, int user_id) {
        this.productName = productName;
        this.category = category;
        this.price = price;
        this.product_status = product_status;
        this.user_id = user_id;
    }

    public Product(int category, double price, byte product_status, int user_id) {
        this.category = category;
        this.price = price;
        this.product_status = product_status;
        this.user_id = user_id;
    }

    public Product(String productName, int category, double price, byte product_status) {
        this.productName = productName;
        this.category = category;
        this.price = price;
        this.product_status = product_status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProduct_item_id() {
        return product_item_id;
    }

    public void setProduct_item_id(String product_item_id) {
        this.product_item_id = product_item_id;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getCategory() {
        return category;
    }

    public void setCategory(int category) {
        this.category = category;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public byte getProduct_status() {
        return product_status;
    }

    public void setProduct_status(byte product_status) {
        this.product_status = product_status;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getContact_info_for_product() {
        return contact_info_for_product;
    }

    public void setContact_info_for_product(String contact_info_for_product) {
        this.contact_info_for_product = contact_info_for_product;
    }

    public String getProduct_image_path() {
        return product_image_path;
    }

    public void setProduct_image_path(String product_image_path) {
        this.product_image_path = product_image_path;
    }

    public MultipartFile getMultipartFile() {
        return multipartFile;
    }

    public void setMultipartFile(MultipartFile multipartFile) {
        this.multipartFile = multipartFile;
    }


    // Add this field to the Product class
    private List<Reaction> reactions;

    // Getter and setter for reactions
    public List<Reaction> getReactions() {
        return reactions;
    }

    public void setReactions(List<Reaction> reactions) {
        this.reactions = reactions;
    }
}
