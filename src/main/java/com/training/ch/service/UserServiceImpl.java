package com.training.ch.service;

import com.training.ch.dao.UserDao;
import com.training.ch.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserDao userDao;

    @Override
    public int registerUser(User user) throws Exception{
        return userDao.insertUser(user);
    }

    @Override
    public int deleteUser(String id, String pwd) throws Exception{
        return userDao.deleteUser(id, pwd);
    }

    @Override
    public int modifyUser(User user) throws Exception{
        return userDao.updateUser(user);
    }

    @Override
    public User selectUser(String id) throws Exception{
        return userDao.selectUser(id);
    }

    @Override
    public String idSearch(User user) throws Exception {
        return userDao.idSearch(user);
    }

    @Override
    public String pwdSearch(User user) throws Exception{
        return userDao.pwdSearch(user);
    }
    @Override
    public int pwdMod(User user) throws Exception{
        return userDao.pwdMod(user);
    }

    @Override
    public User checkUserEmail(String email) throws Exception {
        return userDao.checkUserEmail(email);
    }
}
