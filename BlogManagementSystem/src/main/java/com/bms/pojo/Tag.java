package com.bms.pojo;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "tags")
public class Tag {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "tag_id")
    private int tagId;

    @Column(name = "tag_name", unique = true, nullable = false, length = 50)
    private String tagName;

    @Column(name = "slug", unique = true, nullable = false, length = 50)
    private String slug;

    @Column(name = "created_at")
    private Timestamp createdAt;

    // ⭐ ADD THIS — Many-to-One mapping with Post
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "post_id", nullable = false)
    private Post post;

    // Constructors
    public Tag() {}

    public Tag(String tagName, String slug) {
        this.tagName = tagName;
        this.slug = slug;
    }

    // Getters and Setters
    public int getTagId() {
        return tagId;
    }

    public void setTagId(int tagId) {
        this.tagId = tagId;
    }

    public String getTagName() {
        return tagName;
    }

    public void setTagName(String tagName) {
        this.tagName = tagName;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // ⭐ Getter + Setter for Post
    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }
}
