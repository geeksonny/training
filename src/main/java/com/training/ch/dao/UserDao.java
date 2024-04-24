package com.training.ch.dao;

import com.training.ch.domain.User;

import java.util.List;

public interface UserDao {

    int deleteAll()throws Exception;

    int count() throws Exception;

    int insertUser(User user) throws Exception;

    int deleteUser(String id, String pwd) throws Exception;

    int updateUser(User user) throws Exception;

    User selectUser(String id) throws Exception;

    List<User> selectUserList() throws Exception;

    String idSearch(User user) throws Exception;

    String pwdSearch(User user) throws Exception;

    int pwdMod(User user) throws Exception;

    User checkUserEmail(String email) throws Exception;
}
