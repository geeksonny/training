package com.training.ch.dao;

import com.training.ch.domain.BoardDto;
import com.training.ch.domain.SearchCondition;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class BoardDaoImpl implements BoardDao {
    @Autowired
    private SqlSession session;
    private static String namespace = "com.training.ch.dao.boardMapper.";

    @Override
    public int count() throws Exception {
        return session.selectOne(namespace+"count");
    }

    @Override
    public int deleteAll() throws Exception {
        return session.delete(namespace+"deleteAll");
    }

    @Override
    public int delete(Integer bno, String writer) throws Exception {
        Map map = new HashMap();
        map.put("bno", bno);
        map.put("writer", writer);
        return session.delete(namespace+"delete", map);
    }

    @Override
    public int insert(BoardDto boardDto) throws Exception {
        return session.insert(namespace+"insert", boardDto);
    }

    @Override
    public List<BoardDto> selectAll() throws Exception {
        return session.selectList(namespace+"selectAll");
    }

    @Override
    public BoardDto select(Integer bno) throws Exception {
        return session.selectOne(namespace + "select", bno);
    }

    @Override
    public List<BoardDto> selectPage(Map map) throws Exception {
        return session.selectList(namespace+"selectPage", map);
    }

    @Override
    public int update(BoardDto boardDto) throws Exception {
        return session.update(namespace+"update", boardDto);
    }

    @Override
    public int increaseViewCnt(Integer bno) throws Exception {
        return session.update(namespace+"increaseViewCnt", bno);
    }

    @Override
    public int searchResultCnt(SearchCondition sc) throws Exception {
       return session.selectOne(namespace+"searchResultCnt", sc);
    }

    @Override
    public List<BoardDto> searchSelectPage(SearchCondition sc) throws Exception {
        return session.selectList(namespace+"searchSelectPage", sc);
    }

    @Override
    public int updateCommentCnt(Integer bno, int cnt) throws Exception {
        Map map = new HashMap();
        map.put("cnt", cnt);
        map.put("bno", bno);
        return session.update(namespace+"updateCommentCnt", map);
    }

    @Override
    public int countWrite(Map map) throws Exception{
        return session.selectOne(namespace+"countWrite", map);
    }
}
