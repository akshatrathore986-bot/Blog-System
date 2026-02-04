package com.bms.pojo;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "media")
public class Media {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "media_id")
    private int mediaId;
    
    @ManyToOne
    @JoinColumn(name = "uploader_id", nullable = false)
    private User uploader;
    
    @Column(name = "filename", nullable = false)
    private String filename;
    
    @Column(name = "file_path", nullable = false, length = 500)
    private String filePath;
    
    @Column(name = "file_size")
    private long fileSize;
    
    @Column(name = "mime_type", length = 100)
    private String mimeType;
    
    @Column(name = "alt_text")
    private String altText;
    
    @Column(name = "uploaded_date")
    private Timestamp uploadedDate;
    
    // Constructors
    public Media() {}
    
    // Getters and Setters
    public int getMediaId() {
        return mediaId;
    }
    
    public void setMediaId(int mediaId) {
        this.mediaId = mediaId;
    }
    
    public User getUploader() {
        return uploader;
    }
    
    public void setUploader(User uploader) {
        this.uploader = uploader;
    }
    
    public String getFilename() {
        return filename;
    }
    
    public void setFilename(String filename) {
        this.filename = filename;
    }
    
    public String getFilePath() {
        return filePath;
    }
    
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
    
    public long getFileSize() {
        return fileSize;
    }
    
    public void setFileSize(long fileSize) {
        this.fileSize = fileSize;
    }
    
    public String getMimeType() {
        return mimeType;
    }
    
    public void setMimeType(String mimeType) {
        this.mimeType = mimeType;
    }
    
    public String getAltText() {
        return altText;
    }
    
    public void setAltText(String altText) {
        this.altText = altText;
    }
    
    public Timestamp getUploadedDate() {
        return uploadedDate;
    }
    
    public void setUploadedDate(Timestamp uploadedDate) {
        this.uploadedDate = uploadedDate;
    }
}
