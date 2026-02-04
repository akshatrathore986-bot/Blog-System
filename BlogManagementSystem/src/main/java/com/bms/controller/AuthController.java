package com.bms.controller;

import com.bms.dao.UserDAO;
import com.bms.dao.AuthorDAO;
import com.bms.pojo.User;
import com.bms.pojo.Author;
import com.bms.util.PasswordUtil;
import com.bms.util.SessionUtil;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private AuthorDAO authorDAO;

    // -------------------------
    // LOGIN PAGE
    // -------------------------
    @GetMapping("/login")
    public String loginPage() {
        return "public/login";
    }
 // Admin registration form (GET)
    @GetMapping("/admin-register")
    public String adminRegisterPage() {
        return "public/admin-register";
    }

    // Admin registration (POST)
    @PostMapping("/admin-register")
    @Transactional
    public String adminRegister(@RequestParam String username,
                                @RequestParam String email,
                                @RequestParam String password,
                                @RequestParam String confirmPassword,
                                HttpSession session,
                                Model model) {

        if (username.trim().isEmpty() || email.trim().isEmpty()
                || password.isEmpty() || confirmPassword.isEmpty()) {
            model.addAttribute("error", "All fields are required");
            return "public/admin-register";
        }
        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match");
            return "public/admin-register";
        }
        if (password.length() < 6) {
            model.addAttribute("error", "Password must be at least 6 characters");
            return "public/admin-register";
        }

        if (userDAO.emailExists(email)) {
            model.addAttribute("error", "Email already registered");
            return "public/admin-register";
        }
        if (userDAO.usernameExists(username)) {
            model.addAttribute("error", "Username already taken");
            return "public/admin-register";
        }

        User user = new User();
        user.setUsername(username.trim());
        user.setEmail(email.trim());
        user.setPasswordHash(BCrypt.hashpw(password, BCrypt.gensalt()));
        user.setRole(User.Role.ADMIN);   // IMPORTANT
        user.setStatus(User.Status.ACTIVE);

        userDAO.saveUser(user);

        SessionUtil.setFlashMessage(session, "success", "Admin account created. You can login now.");
        return "redirect:/auth/login";
    }


    // LOGIN PROCESS
    @PostMapping("/login")
    @Transactional
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session,
                        RedirectAttributes redirectAttributes) {

        User user = userDAO.getUserByEmail(email);

        if (user == null || !PasswordUtil.verifyPassword(password, user.getPasswordHash())) {
            redirectAttributes.addFlashAttribute("error", "Invalid email or password");
            return "redirect:/auth/login";
        }

        if (user.getStatus() != User.Status.ACTIVE) {
            redirectAttributes.addFlashAttribute("error", "Your account is not active");
            return "redirect:/auth/login";
        }

        // Update last login
        user.setLastLogin(new Timestamp(System.currentTimeMillis()));
        userDAO.updateUser(user);

        // Set session
        session.setAttribute("loggedInUser", user);
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("userRole", user.getRole().toString());

        // Redirect based on role
        switch (user.getRole()) {
            case ADMIN:
            case SUPER_ADMIN:
                return "redirect:/admin/dashboard";
            case AUTHOR:
                return "redirect:/author/dashboard";
            default:
                return "redirect:/user/dashboard";
        }
    }

    // -------------------------
    // USER REGISTER PAGE
    // -------------------------
    @GetMapping("/register")
    public String registerPage() {
        return "public/register";
    }

    // USER REGISTER PROCESS
    @PostMapping("/register")
    @Transactional
    public String register(@RequestParam String username,
                           @RequestParam String email,
                           @RequestParam String password,
                           @RequestParam String confirmPassword,
                           RedirectAttributes redirectAttributes) {

        if (!password.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "Passwords do not match");
            return "redirect:/auth/register";
        }

        if (userDAO.emailExists(email)) {
            redirectAttributes.addFlashAttribute("error", "Email already exists");
            return "redirect:/auth/register";
        }

        if (userDAO.usernameExists(username)) {
            redirectAttributes.addFlashAttribute("error", "Username already exists");
            return "redirect:/auth/register";
        }

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPasswordHash(PasswordUtil.hashPassword(password));
        user.setRole(User.Role.READER);
        user.setStatus(User.Status.ACTIVE);
        user.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        userDAO.saveUser(user);

        redirectAttributes.addFlashAttribute("success", "Registration successful! Please login.");
        return "redirect:/auth/login";
    }

    // -------------------------
    // AUTHOR REGISTER PAGE (GET)
    // -------------------------
    @GetMapping("/author-register")
    public String authorRegisterPage(Model model) {
        return "public/author-register";
    }

    
    // -------------------------
    // AUTHOR REGISTER PROCESS (POST)
    // -------------------------
    @PostMapping("/author-register")
    @Transactional
    public String authorRegister(@RequestParam String username,
                                 @RequestParam String email,
                                 @RequestParam String password,
                                 @RequestParam String confirmPassword,
                                 @RequestParam(required = false) String displayName,
                                 HttpSession session,
                                 Model model) {

        // Basic validations
        if (username.trim().isEmpty() || email.trim().isEmpty()
                || password.isEmpty() || confirmPassword.isEmpty()) {
            model.addAttribute("error", "All fields are required");
            return "public/author-register";
        }

        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match");
            return "public/author-register";
        }

        if (password.length() < 6) {
            model.addAttribute("error", "Password must be at least 6 characters");
            return "public/author-register";
        }

        if (userDAO.emailExists(email)) {
            model.addAttribute("error", "Email already registered");
            return "public/author-register";
        }

        if (userDAO.usernameExists(username)) {
            model.addAttribute("error", "Username already taken");
            return "public/author-register";
        }

        // 1) Create User as AUTHOR
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPasswordHash(BCrypt.hashpw(password, BCrypt.gensalt()));
        user.setRole(User.Role.AUTHOR);
        user.setStatus(User.Status.ACTIVE);

        userDAO.saveUser(user);

        // 2) Create Author Profile
        Author author = new Author();
        author.setUser(user);
        author.setDisplayName(
                (displayName != null && !displayName.trim().isEmpty())
                        ? displayName.trim()
                        : username
        );
        authorDAO.saveAuthor(author);

        // Flash message
        SessionUtil.setFlashMessage(session,
                "success",
                "Author account created! You can login now.");

        return "redirect:/auth/login";
    }

    // -------------------------
    // LOGOUT
    // -------------------------
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        // Session clear karo
        session.invalidate();
        
        // Flash message (optional)
        // ya redirect ke sath success message
        
        return "redirect:/";  // home page pe le jao
    }

}
