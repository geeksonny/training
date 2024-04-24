package com.training.ch.dao;

import com.training.ch.domain.User;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class UserDaoImpl implements UserDao {

    @Autowired
    private SqlSession session;
    private static String namespace ="com.training.ch.dao.userMapper.";

    @Override
    public int deleteAll()throws Exception{
        return session.delete(namespace+"deleteAll");
    }

    @Override
    public int count() throws Exception{
        return session.selectOne(namespace+"count");
    }

    @Override
    public int insertUser(User user) throws Exception{
        return session.insert(namespace+"insertUser", user);
    }

    @Override
    public int deleteUser(String id, String pwd) throws Exception{
        Map map = new HashMap();
        map.put("id", id);
        map.put("pwd", pwd);
        return session.delete(namespace+"deleteUser", map);
    }

    @Override
    public int updateUser(User user) throws Exception{
        return session.update(namespace+"updateUser", user);
    }
    @Override
    public User selectUser(String id) throws Exception{
        return session.selectOne(namespace+"selectUser", id);
    }

    @Override
    public List<User> selectUserList() throws Exception{
        return session.selectList(namespace+"selectUserList");
    }

    @Override
    public String idSearch(User user) throws Exception{
        return session.selectOne(namespace+"idSearch", user);
    }

    @Override
    public String pwdSearch(User user) throws Exception{
        return session.selectOne(namespace+"pwdSearch", user);
    }

    @Override
    public int pwdMod(User user) throws Exception{
        return session.update(namespace+"pwdMod", user);
    }

    @Override
    public User checkUserEmail(String email) throws Exception{
        return session.selectOne(namespace+"checkUserEmail", email);
    }
}


