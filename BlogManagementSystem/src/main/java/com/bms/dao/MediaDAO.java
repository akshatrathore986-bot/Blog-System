package com.bms.dao;

import com.bms.pojo.Media;
import java.util.List;

public interface MediaDAO {
    void saveMedia(Media media);
    void updateMedia(Media media);
    void deleteMedia(int mediaId);
    Media getMediaById(int mediaId);
    List<Media> getMediaByUploader(int uploaderId);
    List<Media> getAllMedia();
    long getTotalMediaCount();
}
