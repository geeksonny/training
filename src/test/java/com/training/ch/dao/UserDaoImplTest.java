package com.training.ch.dao;

import com.training.ch.domain.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


import java.util.Calendar;
import java.util.Date;
import java.util.List;

import static org.junit.Assert.*;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class UserDaoImplTest {
    @Autowired
    private UserDao userDao;

    @Test
    public void deleteAll() throws Exception{
        userDao.deleteAll();
        assertTrue(userDao.count()==0);
    }

    @Test
    public void count() throws Exception{
        userDao.count();
        assertTrue(userDao.count()==1);
    }

    @Test
    public void insertUserTest() throws Exception{
        User user = new User(2, "qwer","1234","qwer","qqq@aaa.com", new Date(), new Date());
        System.out.println("user = " + user);
        int rowCnt = userDao.insertUser(user);
        assertTrue(rowCnt==1);

    }
    @Test
    public void deleteUserTest() throws  Exception{
        userDao.deleteAll();
        User user = new User(2, "qwer","1234","asdqw","qqq@aaa.com", new Date(), new Date());
        System.out.println("user = " + user);
        int rowCnt = userDao.insertUser(user);
        rowCnt = userDao.deleteUser("qwer","1234");
        assertTrue(rowCnt==1);
    }

    @Test
    public void updateUserTest() throws Exception{
        Calendar cal = Calendar.getInstance();
        cal.clear();
        cal.set(2010,1,1);
        userDao.deleteAll();
        User user = new User(1, "qwer","1234","asdqw","qqq@aaa.com", new Date(), new Date());
        System.out.println("user = " + user);
        int rowCnt = userDao.insertUser(user);
        user.setPwd("1111");
        user.setName("qwer");
        user.setEmail("aaa@aaa.com");
        user.setBirth(new Date(cal.getTimeInMillis()));
        rowCnt = userDao.updateUser(user);
        System.out.println("rowCnt = " + rowCnt);
        System.out.println("user = " + user);
        assertTrue(rowCnt==1);
    }

    @Test
    public void selectUserTest() throws Exception{
        userDao.deleteAll();
        User user = new User(1, "asdfasdf","1234","asdf","aaa@aaa.com", new Date(), new Date());
        System.out.println("user = " + user);
        int rowCnt = userDao.insertUser(user);
        User user2= userDao.selectUser(user.getId());
        System.out.println("user2 = " + user2);
        assertTrue(user.equals(user2.getId()));
    }

    @Test
    public void selectUserListTest()throws Exception{
        List<User> list = userDao.selectUserList();
        for (User user : list){
            System.out.println("user = " + user);
        }
        assertTrue(list.size()==3);
    }

    @Test
    public void searchIdTest() throws Exception{
        userDao.deleteAll();
//        User user;
//        user.setId("asdfasdf");
//        user.setEmail("aaa@aaa.com");
//        String result = userDao.pwdSearch(user);
//        System.out.println("result = " + result);
    }

}