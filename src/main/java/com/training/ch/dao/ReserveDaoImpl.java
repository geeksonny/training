package com.training.ch.dao;

import com.training.ch.domain.ReserveDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ReserveDaoImpl implements ReserveDao {
    @Autowired
    private SqlSession session;
    private static String namespace ="com.training.ch.dao.reserveMapper.";

    @Override
    public int count() throws Exception{
        return session.selectOne(namespace+"count");
    }

    @Override
    public int insertReserve(ReserveDto reserveDto) throws Exception{
        return session.insert(namespace+"insertReserve", reserveDto);
    }

    @Override
    public ReserveDto selectReserve(String id) throws Exception{
        return session.selectOne(namespace+"selectReserve", id);
    }

    @Override
    public List<ReserveDto> selectReserveAll() throws Exception{
        return session.selectList(namespace+"selectReserveAll");
    }

    @Override
    public List<ReserveDto> selectReserveIdAll(String id) throws Exception{
        return session.selectList(namespace+"selectReserveIdAll", id);
    }

    @Override
    public int increaseUseCnt

}
