package com.bms.dao;

import com.bms.pojo.Tag;
import java.util.List;

public interface TagDAO {
    void saveTag(Tag tag);
    void updateTag(Tag tag);
    void deleteTag(int tagId);
    Tag getTagById(int tagId);
    Tag getTagBySlug(String slug);
    List<Tag> getAllTags();
    List<Tag> getTagsByPostId(int postId);
    boolean tagExists(String tagName);
}
