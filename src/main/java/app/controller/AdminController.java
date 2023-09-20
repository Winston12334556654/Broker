package app.controller;

import app.daos.AdminDao;
import app.daos.CustomerDao;
import app.daos.Mail;
import app.daos.ProductDao;
import app.model.Product;
import app.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

@Controller
public class AdminController {


    // Spring security isUserAuthenticated method
    private boolean isUserAuthenticated() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return authentication != null && authentication.isAuthenticated();
    }

    @Autowired
    private AdminDao adminDao;
    private boolean isUserAuthenticated(HttpServletRequest request) {
        // Check if the "id" attribute is present in the session.
        Integer userId = (Integer) request.getSession().getAttribute("id");
        return userId != null;
    }



    //Spring Security starts
    @GetMapping("/admin/viewCustomer")
    @PreAuthorize("hasRole('ADMIN')")
    public String viewCustomers(Model model, HttpServletRequest request) {

        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        List<User> customers = adminDao.getAllUser(); // Get all users from the database

        //Begin to filter
        List<User> filteredCustomers = new ArrayList<>();
        // Filter customers based on role_id value of 2
        for (User customer : customers) {
            if (customer.getRole_id() == 2) {
                filteredCustomers.add(customer);
            }
        }//Done


        model.addAttribute("customers", filteredCustomers);
        return "admin/viewCustomer";
    }


    //Ban Unban Controller which through the locked column of user partially get updated
    @PostMapping("/toggleLock")
    public String toggleLock(@RequestParam int id, @RequestParam boolean lockStatus) {
        boolean newLockStatus = !lockStatus; // Toggle the lock status
        adminDao.updateUserLockStatus(id, newLockStatus); // Update the lock status in the database

        // Redirect back to the user view page with the updated lock status
        return "redirect:/admin/viewCustomer";
    }


    //Ban Unban Controller which through the locked column of user partially get updated
    @PostMapping("/toggleLockSearchedProducts")
    public String toggleLockSearchedProducts(@RequestParam int id, @RequestParam boolean lockStatus) {
        boolean newLockStatus = !lockStatus; // Toggle the lock status
        adminDao.updateProductLockStatus(id, newLockStatus); // Update the lock status in the database for products

        // Redirect back to the user view page with the updated lock status
        return "redirect:/admin/viewProduct";
    }

    @Autowired
    private ProductDao productDao; // Inject the ProductDao bean

    // Unban product
    //Ban Unban Controller which through the locked column of user partially get updated
    @PostMapping("/toggleProductLock")

    public String toggleProductLock(@RequestParam int id, @RequestParam boolean lockStatus) {
    boolean newLockStatus = !lockStatus; // Toggle the lock status
        System.out.println("Product lock status   :  " +newLockStatus);
    adminDao.updateProductLockStatus(id, newLockStatus); // Update the lock status in the database for products

    // Redirect back to the product view page with the updated lock status
    return "redirect:/admin/viewProduct";
}


    @GetMapping("/toggleSearchBanProduct")
    public String displaySearchedProductLockPage(@RequestParam("products") String products, Model model) {
        List<Product> searchResults = productDao.searchProductsByName(products);
        model.addAttribute("searchResults", searchResults);
        return "admin/searchedProductLock"; // Return the view name of the JSP page
    }

    //Admin ban
    @PostMapping("/toggleLockAdmin")
    public String toggleLockAdmin(@RequestParam int id, @RequestParam boolean lockStatus) {
        boolean newLockStatus = !lockStatus; // Toggle the lock status
        adminDao.updateUserLockStatus(id, newLockStatus); // Update the lock status in the database

        // Redirect back to the user view page with the updated lock status
        return "redirect:/admin/viewAdmin";
    }
    // Assuming you have a ProductDao bean

    @GetMapping("/admin/viewProduct")
    public String viewProducts(Model model,HttpServletRequest request){
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "login";
        }
        List<Product> products = adminDao.getAllProducts();
        model.addAttribute("products", products); // Add products to the model

        return "admin/viewProduct"; // Return the view name
    }


    @GetMapping("/admin/forgotPassword")
    public String forgotPassword() {
        return "admin/forgotPassword";
    }

    @PostMapping("/admin/forgotPassword")
    public String sendOtpToEmail(@RequestParam String mail, HttpSession session, Model model) {
        CustomerDao customerDao = new CustomerDao();


        // Check if the email exists in the database
        if (!customerDao.doesEmailExist(mail)) {
            model.addAttribute("error", "User Email not found.");
            return "admin/forgotPassword";
        }

        // If the email exists, proceed with sending OTP
        Mail emailService = new Mail();
        int otp = emailService.otp(6);
        boolean emailSent = emailService.sendEmail(otp, mail);

        if (emailSent) {
            session.setAttribute("otp", otp);
            session.setAttribute("mail", mail);
            return "admin/resetPassword"; // Redirect to OTP verification page
        } else {
            model.addAttribute("error", "Failed to send OTP. Please try again.");
            return "admin/forgotPassword";
        }
    }

@GetMapping("/admin/resetPassword")
public String resetPassword() {
    return "admin/resetPassword";
}

    @PostMapping("/admin/resetPassword")
    public String resetUserPassword(@RequestParam int otp, @RequestParam String password, @RequestParam String confirmpassword, HttpSession session, Model model) {
        int sessionOtp = (int) session.getAttribute("otp");
        String mail = (String) session.getAttribute("mail");
        AdminDao dao = new AdminDao();

        if (otp == sessionOtp) {
            if (password.equals(confirmpassword)) {
                dao.updatePassword(mail, password, confirmpassword);
                // Clear the session attributes
                session.removeAttribute("otp");
                session.removeAttribute("mail");

                return "redirect:/login"; // Redirect to the login page
            } else {
                model.addAttribute("error", "New passwords do not match.");
            }
        } else {
            model.addAttribute("error", "Incorrect OTP. Please enter the correct OTP.");
        }

        return "admin/resetPassword"; // Return to the reset password page with an error message
    }



    @PostMapping(value = "/admin/loginPageAfterForgetPassword")
    public String loginUser(@RequestParam String mail, @RequestParam String password, HttpServletRequest request) {
        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }

        System.out.println("Mail through controller : "+ mail);
        System.out.println("Password through controller : "+ password);
        CustomerDao customerDao = new CustomerDao();

        User customer = customerDao.getCustomerByEmailPass(mail, password);

        if (customer != null) {
            // User authentication successful

            // Set the email in the session
            request.getSession().setAttribute("mail", mail);

            int role_id = customer.getRole_id();
            if (role_id == 2) {
                // User role is customer, redirect to the GET mapping for displaying products
                return "customer/homeCustomer";
            } else if (role_id == 1) {
                // User role is admin
                return "admin/homeAdmin";
            } else {
                // For other roles or no role specified, you can return a default view
                return "customer/aaa"; // Replace with the appropriate view name
            }
        } else {
            // User authentication failed
            // Redirect to an error page or display an error message
            return "admin/loginPageAfterForgetPassword";
        }
    }



    @GetMapping("/admin/searchProducts")
                                        //ndai products gaw jsp kaw na
    public String search(@RequestParam("products") String products, Model model) {
        List<Product> searchResults = productDao.searchProductsByName(products);
        model.addAttribute("searchResults", searchResults);
        return "admin/searchedProducts";
    }

    @GetMapping("/admin/searchUsers")
    public String searchUsers(@RequestParam("users") String searchTerm, Model model) {
        List<User> searchedUsers = adminDao.searchUsers(searchTerm); // Call the DAO method to search for users

        model.addAttribute("searchedUsers", searchedUsers);
        return "admin/searchedUsers"; // Return the name of the JSP page to display searched users
    }
    @GetMapping("/admin/viewAdmin")
    public String viewAdmins(Model model, HttpServletRequest request) {

        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "redirect:/login";
        }
        List<User> admins = adminDao.viewAdminUsers(); // Get admin users from the database

        model.addAttribute("admins", admins);
        return "admin/viewAdmin"; // Return the name of the JSP page to display admin users
    }
}

