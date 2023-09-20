package app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class PageController {

    @GetMapping("/")
    public String HomePage(HttpServletRequest request) {
        // Get the current session
        HttpSession session = request.getSession(false);

        // Check if a session exists
        if (session != null) {
            // Invalidate (kill) the session
            session.invalidate();
        }

        return "home";
    }

    
    @GetMapping ("/login")
    public String logout(){
        return "login";
    }


    private boolean isUserAuthenticated(HttpServletRequest request) {
        // Check if the "id" attribute is present in the session.
        Integer userId = (Integer) request.getSession().getAttribute("id");
        return userId != null;
    }

    @GetMapping("/admin")
    public String admin(HttpServletRequest request){

        if (!isUserAuthenticated(request)) {
            // User is not authenticated. Redirect to the login page.
            return "login";
        }
        return "admin/homeAdmin";
    }
    //pdCategories

    @GetMapping("/testing")
    public String Test(){
        return "test";
    }

}