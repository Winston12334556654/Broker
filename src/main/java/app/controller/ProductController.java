package app.controller;

import app.daos.AdminDao;
import app.daos.CustomerDao;
import app.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import app.daos.ProductDao;
import app.model.Product;


import javax.mail.Multipart;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class ProductController {

    private boolean isUserAuthenticated(HttpServletRequest request) {
        // Check if the "id" attribute is present in the session.
        Integer userId = (Integer) request.getSession().getAttribute("id");
        return userId != null;
    }

    //Spring Security Starts
    @GetMapping("/product/productCreate")
    @PreAuthorize("hasAnyRole('CUSTOMER', 'ADMIN')") // Allow CUSTOMER and ADMIN roles
    public String ProductCreate(HttpServletRequest request) {
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }

        // User is authenticated, proceed with rendering the product creation page.
        return "product/productCreate";
    }

    @GetMapping("/product/productCreateBack")
    public String CustomerCreateBack(HttpServletRequest request, Model model) {
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "login";
        }



        // Retrieve the user's ID from the session
        Integer userId = (Integer) request.getSession().getAttribute("id");
        System.out.println("Session attribute 'id': " + userId );

        // Assuming you have a service method to get user products by ID

        List<Product> userProducts = productDao.getProductsByUserId(userId);

        model.addAttribute("userProducts", userProducts);

        return "customer/homeCustomer";
    }


    @PostMapping(value = "/product/productCreate")
    @PreAuthorize("hasAnyRole('CUSTOMER', 'ADMIN')") // Allow CUSTOMER and ADMIN roles
    public String createProduct(@RequestParam String productName,
                                @RequestParam(required = false, defaultValue = "-1") int category,
                                @RequestParam double price,
                                @RequestParam byte product_status,
                                HttpServletRequest request,
                                @RequestParam String contact_info_for_product,
                                @RequestParam("multipartFile")MultipartFile multipartFile) {

        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        System.out.println(productName);
        System.out.println(category);
        System.out.println(price);
        System.out.println(product_status);
        System.out.println(contact_info_for_product);
        System.out.println("Received Image: " + multipartFile.getOriginalFilename());


        // Get the username of the currently logged-in user from the session



        Integer userId = (Integer) request.getSession().getAttribute("id");

        System.out.println("UserId from session: " + userId);


        // Get the User object from the CustomerDao based on the username
        CustomerDao customerDao = new CustomerDao();
        User customer = customerDao.getCustomerById(userId);

        if (customer == null) {
            // If the customer is null, it means the user is not authenticated. Redirect to the login page.
            System.out.println("User is not authenticated. Redirecting to login.");
            return "redirect:/login";
        }

        // Now you can get the user_id from the customer object
        int user_id = customer.getId();
        System.out.println("User ID: " + user_id);



        //Image Save
       String product_image_path=null;
       if(multipartFile !=null && !multipartFile.isEmpty()){

           //image type hoke lar ma hoke lar ko server backend mar htat sit tar
           if (!multipartFile.getContentType().startsWith("image/")) {
               // Invalid file type
               return "redirect:/product/productCreate"; // Return a view to display an error message
           }


           product_image_path = saveImage(multipartFile,request);

       }



        //Date Lock storing to database begin
        // Get the current date
        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // If the validation passes, create a new Product object with the userId and insert it into the database using the ProductDao.
        Product product = new Product(productName, category, price, product_status, user_id, contact_info_for_product,product_image_path);

        product.setLocked(false);
        product.setCreated_date(currentDate);
        //Date Lock storing to database close

        ProductDao productDao = new ProductDao();
        int status = productDao.createProduct(product);

        if (status > 0) {
            // Product created successfully, you can redirect to a success page or perform further actions.
            return "redirect:/customer/homeCustomer"; // Return the view for the success page or menu page.
        } else {
            // Failed to create the product, you can redirect to an error page or display an error message.
            return "product/productCreate"; // Return a view for displaying an error message.
        }
    }







    private String saveImage(MultipartFile multipartFile , HttpServletRequest request){
        String originalFileName = multipartFile.getOriginalFilename();
        String imageExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        String image = System.currentTimeMillis() + imageExtension;
        String rootDirectory = request.getSession().getServletContext().getRealPath("/");
        Path path = Paths.get(rootDirectory + "/WEB-INF/productImage/" + image);

        if (multipartFile != null && !multipartFile.isEmpty()){
            try {
                multipartFile.transferTo(new File(path.toString()));
            } catch (IOException e){
                e.printStackTrace();
            }
        }

        return image;
    }

    //Image Save Method
//    private String saveImage(MultipartFile multipartFile , HttpServletRequest request){
//        String image = System.currentTimeMillis()+ ".png";//only name in the image's file type database
//        String rootDirectory = request.getSession().getServletContext().getRealPath("/");
//        Path path = Paths.get(rootDirectory+ "/WEB-INF/productImage/"+image);
//        if (multipartFile !=null && !multipartFile.isEmpty()){
//            try {
//                multipartFile.transferTo(new File (path.toString()));
//            }catch (IOException e){
//                e.printStackTrace();
//            }
//        }
//        return image;
//    }

//    @GetMapping("product/productView")
//    private String productView(HttpServletRequest request){
//        // Check if the user is authenticated
//        if (!isUserAuthenticated(request)) {
//            // User is not authenticated. Redirect to the login page.
//            return "redirect:/login";
//        }
//
//        // User is authenticated, proceed with rendering the product creation page.
//
//        return "product/productView";
//    }

    @GetMapping("/product/productView")
    public String productView(HttpServletRequest request) {
        // Logic for handling the request goes here

        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "product/productView"; // This should match the name of your view (e.g., a JSP or Thymeleaf template)
    }

    //pdCategories
    @GetMapping("/categories/electronics")
    private String electricalProducts(HttpServletRequest request){
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/electronics";
    }
    @GetMapping("/categories/fashion")
    private String clothingProducts(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }

        return "categories/fashion";
    }
    @GetMapping("/categories/home")
    private String home(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/home";
    }
    @GetMapping("/categories/beauty")
    private String beauty(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/beauty";
    }
    @GetMapping("/categories/fitness")
    private String fitness(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/fitness";
    }
    @GetMapping("/categories/food")
    private String food(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/food";
    }
    @GetMapping("/categories/tech")
    private String tech(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/tech";
    }
    @GetMapping("/categories/toys")
    private String toys(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/toys";
    }
    @GetMapping("/categories/books")
    private String books(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }

        return "categories/books";
    }
    @GetMapping("/categories/automotive")
    private String automotive(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/automotive";
    }
    @GetMapping("/categories/sports")
    private String sports(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/sports";
    }
    @GetMapping("/categories/arts")
    private String arts(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/arts";
    }
    @GetMapping("/categories/jewelry")
    private String jewelry(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/jewelry";
    }
    @GetMapping("/categories/electrical")
    private String electrical(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/electrical";
    }
    @GetMapping("/categories/baby")
    private String baby(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/baby";
    }
    @GetMapping("/categories/pet")
    private String pet(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/pet";
    }
    @GetMapping("/categories/gardening")
    private String gardening(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/gardening";
    }
    @GetMapping("/categories/collectibles")
    private String collectibles(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/collectibles";
    }
    @GetMapping("/categories/travel&luggage")
    private String travelLuggage(HttpServletRequest request){

        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/travel&luggage";
    }

    @GetMapping("/categories/other")
    private String otherProducts(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/other";
    }
    @GetMapping("/categories/estate")
    private String realEstate(HttpServletRequest request){
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        return "categories/realEstate";
    }


    @Autowired
    private ProductDao productDao; // Inject your ProductDao here

    //Product search by user
    @GetMapping("/search")
    public String search(@RequestParam("query") String query, Model model) {
        List<Product> searchResults = productDao.searchProductsByName(query);
        model.addAttribute("searchResults", searchResults);
        return "product/searchResultsView";
    }


    //Update product
    @GetMapping("/updateProduct")
    public String updateProductForm(@RequestParam("id") int productId, Model model) {
        Product product = productDao.getProductById(productId);
        model.addAttribute("product", product);
        return "product/productUpdate"; // Return the name of the JSP page for the update form
    }

    @PostMapping("/updateProduct")
    public String updateProduct(@ModelAttribute Product updatedProduct, @RequestParam("productImage") MultipartFile productImage, HttpServletRequest request) {
        // Get the existing product from the database
        Product existingProduct = productDao.getProductById(updatedProduct.getId());

        // Update the product details with the new values
        existingProduct.setProductName(updatedProduct.getProductName());
        existingProduct.setPrice(updatedProduct.getPrice());
        existingProduct.setCategory(updatedProduct.getCategory()); // Updated category value
        existingProduct.setProduct_status(updatedProduct.getProduct_status()); // Updated product status value
        existingProduct.setContact_info_for_product(updatedProduct.getContact_info_for_product());

        System.out.println("Product status   :    :   : "+ updatedProduct.getProduct_status());

        // Update the product image if a new image is provided
        if (!productImage.isEmpty()) {
            String imagePath = saveImage(productImage, request); // Call the saveImage method with correct parameters
            existingProduct.setProduct_image_path(imagePath);
        }

        // Update the product in the database
        int rowsAffected = productDao.updateProduct(existingProduct);

        if (rowsAffected > 0) {
//            return "redirect:/productDetails?id=" + existingProduct.getId();
            return "redirect:/customer/homeCustomer";
        } else {
            // Handle update failure
            return "redirect:/errorPage";
        }
    }





    @Autowired
    private AdminDao adminDao;

    @Autowired
    private CustomerDao customerDao;

    @PostMapping("/deleteProduct")
    public String deleteProductAndUpdateLockStatus(@RequestParam("id") int productId, HttpServletRequest request, Model model) {
        // Call the DAO method to update the product lock status
        adminDao.updateProductLockStatus(productId, true); // Lock the product

        // Retrieve the user's ID from the session
        String name = (String) request.getSession().getAttribute("name");
        int userId = customerDao.getUserIdByName(name);

        // Assuming you have a service method to get user products by ID
        List<Product> userProducts = productDao.getProductsByUserId(userId);
        model.addAttribute("userProducts", userProducts);

        return "redirect:/customer/homeCustomer"; // Redirect to the product view page with updated user products
    }




    @GetMapping("/productsByRole")
    public String getProductsForPremiumUsers(Model model) {
        int premiumRoleId = 3; // Assuming 3 is the role ID for premium users

        // Assuming you have a service method to get products by role_id
        List<Product> roleProducts = productDao.getRandomProductsByRole(premiumRoleId);

        // Add logging or print statements to see the retrieved products
        for (Product product : roleProducts) {
            System.out.println("Product ID: " + product.getId());
            System.out.println("Product Name: " + product.getProductName());
            // Add more properties as needed
        }

        model.addAttribute("roleProducts", roleProducts);

        return "product/productsByRole"; // Replace with the appropriate view name
    }






}


