package com.training.ch.dao;

import com.training.ch.domain.BoardDto;
import com.training.ch.domain.EquipmentDto;
import com.training.ch.domain.SearchCondition;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class EquipDaoImpl implements EquipDao {
    @Autowired
    private SqlSession session;
    private static String namespace ="com.training.ch.dao.equipMapper.";

    @Override
    public List<EquipmentDto> searchSelectPage(SearchCondition sc) throws Exception {
        return session.selectList(namespace+"searchSelectPage", sc);
    }

    @Override
    public EquipmentDto select(int eno) throws Exception {
        return session.selectOne(namespace+"select", eno);
    }

    @Override
    public List<EquipmentDto> selectEquipCategory(int eCategory, SearchCondition sc) throws Exception{
        Map map = new HashMap();
        map.put("eCategory", eCategory);
        map.put("offset", sc.getOffset());
        map.put("pageSize", sc.getPageSize());
        return session.selectList(namespace+"selectEquipCategory", map);
    }

    @Override
    public int getResultCnt(int eCategory) throws Exception {
        return session.selectOne(namespace+"getResultCnt", eCategory);
    }

    @Override
    public int getSearchResultCnt(SearchCondition sc) throws Exception{
        return session.selectOne(namespace+"getSearchResultCnt", sc);

    }

    @Override
    public List<EquipmentDto> getSearchResultPage(SearchCondition sc) throws Exception{
        return session.selectList(namespace+"getSearchResultPage", sc);
    }

}
