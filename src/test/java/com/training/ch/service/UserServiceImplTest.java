package com.training.ch.service;

import com.training.ch.dao.UserDao;
import com.training.ch.domain.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Calendar;
import java.util.Date;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class UserServiceImplTest {

    @Autowired
    UserDao userDao;

    @Test
    public void registerUserTest() throws Exception {
        User user = new User(5, "adgh", "1234", "adgh", "aaa@aaa.com", new Date(), new Date());
        assertTrue(userDao.insertUser(user)==1);
    }

    @Test
    public void deleteUserTest() throws Exception {
        assertTrue(userDao.deleteUser("adgh", "1234")==1);
    }

    @Test
    public void modifyUserTest() throws Exception {
        Calendar cal = Calendar.getInstance();
        cal.clear();
        User user = new User(5, "adgh", "1234", "adgh", "aaa@aaa.com", new Date(), new Date());
        int rowCnt = userDao.insertUser(user);
        user.setPwd("123123");
        user.setName("qety");
        user.setEmail("bbb@bbb.com");
        user.setBirth(new Date(cal.getTimeInMillis()));
        System.out.println("user = " + user);
        rowCnt = userDao.updateUser(user);
        assertTrue(rowCnt==1);
    }

    @Test
    public void setUserTest() throws Exception{
        User user = userDao.selectUser("asas");
        System.out.println("user = " + user);
    }

}