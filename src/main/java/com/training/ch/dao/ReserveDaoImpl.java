package com.training.ch.dao;

import com.training.ch.domain.ReserveDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public int cancelUseCnt(int rno, String type, int reserve_state) throws Exception{
        Map map = new HashMap();
        map.put("rno", rno);
        map.put("type", type);
        map.put("reserve_state", reserve_state);
        return session.update(namespace+"cancelUseCnt", map);
    }

}
