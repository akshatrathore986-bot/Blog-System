package com.bms.dao;

import com.bms.pojo.Category;
import java.util.List;

public interface CategoryDAO {
    void saveCategory(Category category);
    void updateCategory(Category category);
    void deleteCategory(int categoryId);
    Category getCategoryById(int categoryId);
    Category getCategoryBySlug(String slug);
    List<Category> getAllCategories();
    List<Category> getPopularCategories(int limit);
    boolean categoryExists(String categoryName);
    boolean slugExists(String slug);
}
