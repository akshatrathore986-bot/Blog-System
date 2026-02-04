package com.bms.dao;

import com.bms.pojo.User;
import java.util.List;

public interface UserDAO {
    void saveUser(User user);
    void updateUser(User user);
    void deleteUser(int userId);
    User getUserById(int userId);
    User getUserByEmail(String email);
    User getUserByUsername(String username);
    List<User> getAllUsers();
    List<User> getUsersByRole(User.Role role);
    List<User> getUsersByStatus(User.Status status);
    long getTotalUsersCount();
    boolean emailExists(String email);
    boolean usernameExists(String username);
}
