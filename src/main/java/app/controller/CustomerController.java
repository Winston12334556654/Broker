package app.controller;

import app.daos.*;
import app.model.Notification;
import app.model.Product;

import app.model.Reaction;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;
/*import app.daos.Mail;*/
import app.model.User;
import org.springframework.web.bind.annotation.GetMapping;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

//import static app.controller.OTPGenerator.generateOTP;


@Controller
public class CustomerController {


    @GetMapping("/customer/aaa")
    public String aaa() {
        return "customer/aaa";
    }


    @GetMapping("/customer/customerCreate")
    public String CustomerCreate() {
        return "customer/customerCreate";
    }

    @PostMapping("/customer/customerCreate")
    public String customerCreatePost(
            @RequestParam String name,
            String password,
            String confirmPassword,
            String mail,
            String phone,
            String address,
            @RequestParam("profileImage") MultipartFile profileImage,
            HttpServletRequest request,
            HttpSession session) {


        // Get the username of the currently logged-in user from the session

        String userName = (String) request.getSession().getAttribute("name");
        System.out.println("Name  :  " + name);
        System.out.println("Password   :  " + password);
        System.out.println("confirm password   :  " + confirmPassword);
        System.out.println("mail     :    " + mail);
        System.out.println("phone    :   " + phone);
        System.out.println("Address    :  " + address);
        System.out.println("Image    :   " + profileImage);


        LocalDate currentDate = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        User customer = new User(name, password, confirmPassword, mail, phone, address);
        customer.setCreated_date(currentDate);
        customer.setRole_id(2);
        customer.setLocked(false);

        CustomerDao dao = new CustomerDao();

        Mail email = new Mail();
        int otp = email.otp(6);
        email.sendEmail(otp, mail);
        session.setAttribute("otp", otp);

        // Handle the uploaded profile image
        // Handle the uploaded profile image
        String profileImagePath = null;
        if (profileImage != null && !profileImage.isEmpty()) {
            if (!profileImage.getContentType().startsWith("image/")) {
                // Invalid file type
                return "customer/customerCreate"; // Return a view to display an error message
            }
            profileImagePath = saveImage(profileImage, request);
        }

        customer.setUser_image_path(profileImagePath); // Set the profile image path in the user object

        int status = dao.createCustomer(customer);
        if (status == 1) {
            return "customer/verifyOTP";
        }
        return "customer/customerCreate";
    }

    private String saveImage(MultipartFile multipartFile, HttpServletRequest request) {
        String originalFileName = multipartFile.getOriginalFilename();
        String imageExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        String image = System.currentTimeMillis() + imageExtension;
        String rootDirectory = request.getSession().getServletContext().getRealPath("/");
        Path path = Paths.get(rootDirectory + "/WEB-INF/productImage/" + image); // Update the path

        if (multipartFile != null && !multipartFile.isEmpty()) {
            try {
                multipartFile.transferTo(new File(path.toString()));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return image;
    }

    @GetMapping("/verifyOtp")
    public String OTP() {
        return "customer/verifyOTP";
    }

    // Create a method to validate OTP
    private boolean validateOTP(HttpSession session, int enteredOTP) {
        int storedOTP = (int) session.getAttribute("otp");
        return enteredOTP == storedOTP;
    }

    @PostMapping("/verifyOtp")
    public String verifyOtp(@RequestParam int otp, HttpSession session, Model model) {
        if (validateOTP(session, otp)) {
            // OTP is valid, allow access to the desired page (e.g., login)
            return "login"; // Replace with the actual URL
        } else {
            model.addAttribute("error", "Invalid OTP. Please try again.");
            return "customer/verifyOTP";
        }
    }

//    @PostMapping("/verifyOtp")
//    public String verifyOtp(@RequestParam int otp, HttpSession session, Model model) {
//        session.setAttribute("otp", otp);
//        int storedOtp = (Integer) session.getAttribute("otp");
//        if (otp == storedOtp) {
//            return "login";
//        }
//        model.addAttribute("error", "Invalid OTP. Please try again.");
//        return "customer/verifyOTP";
//    }


    @Autowired
    private CustomerDao customerDao;

    @Autowired
    private ProductDao productDao;

    @Autowired
    private ReactionDao reactionDao;


    private boolean isUserAuthenticated(HttpServletRequest request) {
        // Check if the "id" attribute is present in the session.
        Integer userId = (Integer) request.getSession().getAttribute("id");
        return userId != null;
    }


    //Spring security starts
    @GetMapping("/customer/homeCustomer")
    @PreAuthorize("hasRole('CUSTOMER')")
    public String displayHomeCustomerPage(HttpServletRequest request, Model model) {
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "login";
        }

        // Retrieve the user's ID from the session
        Integer userId = (Integer) request.getSession().getAttribute("id");

        // Assuming you have a service method to get user products by user ID
        List<Product> userProducts = productDao.getProductsByUserId(userId);

        User user = customerDao.getCustomerById(userId); // Fetch user's information
        model.addAttribute("userProducts", userProducts);
        model.addAttribute("user", user); // Add the user object to the model

        return "customer/homeCustomer";
    }


    @PostMapping(value = "/customer/homeCustomer")
    public String loginUser(@RequestParam String email, @RequestParam String password, HttpServletRequest request, Model model) {
        CustomerDao customerDao = new CustomerDao();

        User customer = customerDao.getUserEmailPassword(email, password);

        if (customer != null) {
            // User authentication successful

            // Check if the user is banned
            if (customer.isLocked()) {
                // User is locked
                // You can display a warning message and a link here
                model.addAttribute("error", "You are banned from this website. ");
                model.addAttribute("linkText", "See more"); // Text for the link
                model.addAttribute("linkURL", "/#"); // URL for the link
                return "login"; // Return to the login page
            }

            // Retrieve the user's ID from your database query (assuming you have a method for it)
            int userId = customer.getId(); // Replace this with the actual method to retrieve the user's ID
            System.out.println("User's ID: " + customer.getId());

            // Set the user's ID in the session
            request.getSession().setAttribute("id", userId);
            System.out.println("Debugged session role_id in post loginUser method: " + customer.getRole_id());

            int role_id = customer.getRole_id();
            if (role_id == 2) {
                // User role is customer, redirect to the GET mapping for displaying products
                return "redirect:/customer/homeCustomer";
            } else if (role_id == 1) {
                // User role is admin
                return "redirect:/admin/viewCustomer";
            } else if (role_id == 3) {
                // User role is some other role; define the appropriate redirection
                return "redirect:/customer/homeCustomer"; // Replace with the correct route
            } else {
                // For other roles or no role specified, you can return a default view
                return "/404"; // Replace with the appropriate view name
            }
        } else {
            // User authentication failed
            // Redirect to an error page or display an error message
            model.addAttribute("error", "Invalid User name or Password. Please Try again.");
            return "login";
        }
    }


    @GetMapping("/editProfile")
    public String editProfileForm(@RequestParam("id") int userId, Model model) {
        User user = customerDao.getCustomerById(userId); // Replace with your actual DAO method

        System.out.println("User name : " + user.getName());
        model.addAttribute("user", user);
        return "customer/customerEdit"; // Return the name of the JSP page for editing the profile
    }


    @PostMapping("/updateProfile")
    public String updateProfile(@ModelAttribute User user,
                                @RequestParam("profileImage") MultipartFile profileImage,
                                @RequestParam("id") int userId, // Use @RequestParam to get the user ID
                                @RequestParam("confirmPassword") String confirmPassword, // Add this parameter
                                Model model, HttpServletRequest request) {
        // Validate and process the form data here
        System.out.println("Confirm Password    :     " + confirmPassword);

        User existingUser = customerDao.getUserById(user.getId());

        System.out.println("Get id : " + user.getId());

        if (user.getConfirmpassword() == null || user.getConfirmpassword().isEmpty()) {
            user.setConfirmpassword(existingUser.getConfirmpassword());
        } else {
            user.setConfirmpassword(confirmPassword); // Set the confirm password from the form submission
        }

        // Update the product details with the new values

        existingUser.setName(user.getName());

        existingUser.setPassword(user.getPassword());
        existingUser.setConfirmpassword(user.getConfirmpassword());
        existingUser.setMail(user.getMail());
        existingUser.setPhone(user.getPhone());

        existingUser.setAddress(user.getAddress());
        existingUser.setPassword(user.getPassword());

        // Update the user's profile information and image

        if (!profileImage.isEmpty()) {
            String imagePath = saveImage(profileImage, request); // Call the saveImage method with correct parameters
            existingUser.setUser_image_path(imagePath);
        }

        System.out.println("Confirm Password (Before Update): " + confirmPassword);

// Update the user's profile information in the database
        int updateStatus = customerDao.updateCustomer(existingUser);

        System.out.println("Update Status: " + updateStatus); // Print the update status

        if (updateStatus > 0) {
            // Successfully updated user profile
            return "redirect:/customer/homeCustomer"; // Redirect to the user's profile page
        } else {
            // Failed to update user profile
            model.addAttribute("updateError", true);
            return "redirect:/customer/customerEdit"; // Return to the edit profile page with error
        }
    }


    @GetMapping("/tryPremium")
    public String tryPremium(@RequestParam int id) {
        // Update the user's role to premium and set subscription expiration
        customerDao.updateRoleToPremiumAndSetExpiration(id);
        return "redirect:/customer/homeCustomer"; // Redirect to user profile page
    }


    //Reactionnnnnnnnnn


    @Autowired
    private NotificationService notificationService; // You'll need a NotificationService to handle notifications

    @Autowired
    private CustomerDao userDao; // You'll need a UserDao to fetch user information

//    @Autowired
//    private ProductService productService; // You'll need a ProductService to fetch product information

    @PostMapping("/pokeProduct")
    @PreAuthorize("hasAnyRole('CUSTOMER')") // Allow CUSTOMER and ADMIN roles
    public String pokeProduct(
            @RequestParam int productId,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes
    ) {
        // Check if the user is authenticated
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }

        // Get the user's ID from the session
        int userId = (int) request.getSession().getAttribute("id");

        // Check if the user has already poked this product
        if (reactionDao.hasUserPokedProduct(userId, productId)) {
            // User has already poked this product, handle it accordingly (e.g., show an error message)
            redirectAttributes.addFlashAttribute("error", "You've already poked this product.");
            return "redirect:/product/productView?id=" + productId;
        }

        // Create a new Reaction object to represent the poke
        Reaction reaction = new Reaction();
        reaction.setUserId(userId);
        reaction.setProductId(productId);
        reaction.setType("poke"); // You can use a string like "poke" to represent the reaction type

        // Save the reaction to the database
        reactionDao.saveReaction(reaction);

        // Get the seller's user ID based on the product's ID
        int sellerUserId = userDao.getUserIdByProductId(productId);

        // Check if the seller's user ID is different from the user who poked
        if (sellerUserId != userId) {
            // Create a notification for the seller
            notificationService.generatePokeNotification(userId, productId, sellerUserId);
        }

        // Redirect back to the product view page with a success message
        redirectAttributes.addFlashAttribute("success", "You poked this product!");
        return "redirect:/product/productView?id=" + productId;
    }

    // Other controller methods...

    @Autowired
    private NotificationDao notificationDao;
    @GetMapping("/notification")
    public String showNotifications(Model model, HttpServletRequest request) {
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }

        // Get the user's ID and name from the session
        int userId = (int) request.getSession().getAttribute("id");
        String userName = (String) request.getSession().getAttribute("username");

        // Retrieve notifications from the database using the DAO
        List<Notification> notifications = notificationDao.getNotificationsByUserId(userId);

        // Add the list of notifications and user's name to the model
        model.addAttribute("notifications", notifications);
        model.addAttribute("userName", userName);

        // Iterate through the notifications and print sender's name
        for (Notification notification : notifications) {
            System.out.println("Sender's Name: " + notification.getSenderName());
            // Print other notification details if needed
        }

        return "product/notification";
    }

}




//    @PostMapping("/pokeProduct")
//    @PreAuthorize("hasAnyRole('CUSTOMER')") // Allow CUSTOMER and ADMIN roles
//    public String pokeProduct(
//            @RequestParam int productId,
//            HttpServletRequest request,
//            RedirectAttributes redirectAttributes
//    ) {
//
//
//        System.out.println("ProductId      :       "+ productId);
//        // Check if the user is authenticated
//        if (!isUserAuthenticated(request)) {
//            // User is not authenticated. Redirect to the login page.
//            return "redirect:/login";
//        }
//
//        // Get the user's ID from the session
//        int userId = (int) request.getSession().getAttribute("id");
//
//        // Check if the user has already poked this product (you can use productItemId for this check)
//        if (reactionDao.hasUserPokedProduct(userId, productId)) { // Call the method using reactionDao
//            // User has already poked this product, handle it accordingly (e.g., show an error message)

//            System.out.println("Whether reacted or not checking boolean   :    "+ reactionDao.hasUserPokedProduct(userId,productId));
//            redirectAttributes.addFlashAttribute("error", "You've already poked this product.");
//            return "redirect:/product/productView?id=" + productId;
//        }
//
//        // Create a new Reaction object to represent the poke
//        Reaction reaction = new Reaction();
//        reaction.setUserId(userId);
//        reaction.setProductId(productId);
//        reaction.setType("poke"); // You can use a string like "poke" to represent the reaction type
//
//        // Save the reaction to the database (you can use productId for this)
//        reactionDao.saveReaction(reaction);
//
//        // Redirect back to the product view page with a success message
//        redirectAttributes.addFlashAttribute("success", "You poked this product!cccccc");
//        return "redirect:/product/productView?id=" + productId;
//
//    }

