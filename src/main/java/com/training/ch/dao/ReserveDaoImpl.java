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
    public int cancelUseCnt(int rno, String type) throws Exception{
        Map map = new HashMap();
        map.put("rno", rno);
        map.put("type", type);
        return session.update(namespace+"cancelUseCnt", map);
    }

    @Override
    public int completeUse(int rno, String type) throws Exception{
        Map map = new HashMap();
        map.put("rno", rno);
        map.put("type", type);
        return session.update(namespace+"completeUse", map);
    }


    @Override
    public int isAlreadyReserved(ReserveDto reserveDto) throws Exception{
        return session.selectOne(namespace+"isAlreadyReserved", reserveDto);
    }

    @Override
    public int otherReserved(ReserveDto reserveDto) throws Exception{
        return session.selectOne(namespace+"otherReserved", reserveDto);
    }

    @Override
    public int canceledReserve(ReserveDto reserveDto) throws Exception{
        return session.selectOne(namespace+"canceledReserve", reserveDto);
    }

    @Override
    public int countReserve(String id) throws Exception{
        return session.selectOne(namespace+"countReserve", id);
    }

    @Override
    public int countCanceledReserve(String id) throws Exception{
        return session.selectOne(namespace+"countCanceledReserve", id);
    }

    @Override
    public int countCompletedReserve(String id) throws Exception{
        return session.selectOne(namespace+"countCompletedReserve", id);
    }

    @Override
    public int countReservation(String id) throws Exception{
        return session.selectOne(namespace+"countReservation", id);
    }

    @Override
    public List<ReserveDto> selectCurrentReserve(String id) throws Exception{
        return session.selectList(namespace+"selectCurrentReserve", id);
    }

    @Override
    public List<ReserveDto> selectCanceledReserve(String id) throws Exception{
        return session.selectList(namespace+"selectCanceledReserve", id);
    }

    @Override
    public List<ReserveDto> selectCompletedReserve(String id) throws Exception{
        return session.selectList(namespace+"selectCompletedReserve", id);
    }


}
