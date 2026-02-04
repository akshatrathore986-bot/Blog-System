package com.bms.pojo;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "authors")
public class Author {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "author_id")
    private int authorId;
    
    @OneToOne
    @JoinColumn(name = "user_id", unique = true, nullable = false)
    private User user;
    
    @Column(name = "display_name", nullable = false, length = 100)
    private String displayName;
    
    @Column(name = "bio", columnDefinition = "TEXT")
    private String bio;
    
    @Column(name = "profile_image")
    private String profileImage;
    
    @Column(name = "website_url")
    private String websiteUrl;
    
    @Column(name = "social_twitter", length = 100)
    private String socialTwitter;
    
    @Column(name = "social_linkedin", length = 100)
    private String socialLinkedin;
    
    @Column(name = "social_instagram", length = 100)
    private String socialInstagram;
    
    @Column(name = "followers_count")
    private int followersCount = 0;
    
    @Column(name = "created_at")
    private Timestamp createdAt;
    
    // Constructors
    public Author() {}
    
    // Getters and Setters
    public int getAuthorId() {
        return authorId;
    }
    
    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public String getDisplayName() {
        return displayName;
    }
    
    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }
    
    public String getBio() {
        return bio;
    }
    
    public void setBio(String bio) {
        this.bio = bio;
    }
    
    public String getProfileImage() {
        return profileImage;
    }
    
    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage;
    }
    
    public String getWebsiteUrl() {
        return websiteUrl;
    }
    
    public void setWebsiteUrl(String websiteUrl) {
        this.websiteUrl = websiteUrl;
    }
    
    public String getSocialTwitter() {
        return socialTwitter;
    }
    
    public void setSocialTwitter(String socialTwitter) {
        this.socialTwitter = socialTwitter;
    }
    
    public String getSocialLinkedin() {
        return socialLinkedin;
    }
    
    public void setSocialLinkedin(String socialLinkedin) {
        this.socialLinkedin = socialLinkedin;
    }
    
    public String getSocialInstagram() {
        return socialInstagram;
    }
    
    public void setSocialInstagram(String socialInstagram) {
        this.socialInstagram = socialInstagram;
    }
    
    public int getFollowersCount() {
        return followersCount;
    }
    
    public void setFollowersCount(int followersCount) {
        this.followersCount = followersCount;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}

