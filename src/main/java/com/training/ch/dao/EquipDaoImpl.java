package com.training.ch.dao;

import com.training.ch.domain.BoardDto;
import com.training.ch.domain.EquipmentDto;
import com.training.ch.domain.SearchCondition;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class EquipDaoImpl implements EquipDao {
    @Autowired
    private SqlSession session;
    private static String namespace ="com.training.ch.dao.equipMapper.";

    @Override
    public int getCount() throws Exception{
        return session.selectOne(namespace+"getCount");
    }

    @Override
    public List<EquipmentDto> selectEquipListAll() throws Exception{
        return session.selectList(namespace+"selectEquipListAll");
    }

    @Override
    public int searchResultCnt(SearchCondition sc) throws Exception {
        return session.selectOne(namespace+"searchResultCnt", sc);
    }

    @Override
    public List<EquipmentDto> searchSelectPage(SearchCondition sc) throws Exception {
        return session.selectList(namespace+"searchSelectPage", sc);
    }

    @Override
    public EquipmentDto select(int eno) throws Exception {
        return session.selectOne(namespace+"select", eno);
    }

}
