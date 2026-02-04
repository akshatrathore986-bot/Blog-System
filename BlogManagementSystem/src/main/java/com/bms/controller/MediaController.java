package com.bms.controller;

import com.bms.dao.MediaDAO;
import com.bms.dao.UserDAO;
import com.bms.pojo.Media;
import com.bms.pojo.User;
import com.bms.util.FileUploadUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@Controller
@RequestMapping("/media")
public class MediaController {
    
    @Autowired
    private MediaDAO mediaDAO;
    
    @Autowired
    private UserDAO userDAO;
    
    // Media library
    @GetMapping("/library")
    @Transactional
    public String mediaLibrary(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        List<Media> mediaList = mediaDAO.getAllMedia();
        model.addAttribute("mediaList", mediaList);
        
        return "admin/media-library";
    }
    
    // Upload media
    @PostMapping("/upload")
    @Transactional
    public String uploadMedia(@RequestParam MultipartFile file,
                             @RequestParam(required = false) String altText,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        try {
            String fileName = FileUploadUtil.saveFile("uploads/media", file.getOriginalFilename(), file);
            
            Media media = new Media();
            media.setUploader(user);
            media.setFilename(file.getOriginalFilename());
            media.setFilePath("uploads/media/" + fileName);
            media.setFileSize(file.getSize());
            media.setMimeType(file.getContentType());
            media.setAltText(altText);
            media.setUploadedDate(new Timestamp(System.currentTimeMillis()));
            
            mediaDAO.saveMedia(media);
            
            redirectAttributes.addFlashAttribute("success", "File uploaded successfully");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "File upload failed");
            e.printStackTrace();
        }
        
        return "redirect:/media/library";
    }
    
    // Delete media
    @GetMapping("/delete/{id}")
    @Transactional
    public String deleteMedia(@PathVariable int id, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        Media media = mediaDAO.getMediaById(id);
        if (media != null) {
            FileUploadUtil.deleteFile(media.getFilePath());
            mediaDAO.deleteMedia(id);
            redirectAttributes.addFlashAttribute("success", "Media deleted successfully");
        }
        
        return "redirect:/media/library";
    }
}
