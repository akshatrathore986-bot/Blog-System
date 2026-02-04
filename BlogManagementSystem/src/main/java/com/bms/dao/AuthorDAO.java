package com.bms.dao;

import com.bms.pojo.Author;
import java.util.List;

public interface AuthorDAO {
    void saveAuthor(Author author);
    void updateAuthor(Author author);
    void deleteAuthor(int authorId);
    Author getAuthorById(int authorId);
    Author getAuthorByUserId(int userId);
    List<Author> getAllAuthors();
    List<Author> getTopAuthors(int limit);
    long getTotalAuthorsCount();
}
