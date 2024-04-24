package com.training.ch.service;

import com.training.ch.domain.User;

public interface UserService {
    int registerUser(User user) throws Exception;

    int deleteUser(String id, String pwd) throws Exception;

    int modifyUser(User user) throws Exception;

    User selectUser(String id) throws Exception;

    String idSearch(User user) throws Exception;

    String pwdSearch(User user) throws Exception;

    int pwdMod(User user) throws Exception;

    User checkUserEmail(String email) throws Exception;
}
