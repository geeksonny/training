package com.training.ch.dao;

import com.training.ch.domain.BoardDto;
import com.training.ch.domain.SearchCondition;

import java.util.List;
import java.util.Map;

public interface BoardDao {
    int count() throws Exception;

    int deleteAll();

    int delete(Integer bno, String writer) throws Exception;

    int insert(BoardDto dto) throws Exception;

    List<BoardDto> selectAll() throws Exception;

    BoardDto select(Integer bno) throws Exception;

    List<BoardDto> selectPage(Map map) throws Exception;

    int update(BoardDto dto) throws Exception;

    int increaseViewCnt(Integer bno) throws Exception;

    int searchResultCnt(SearchCondition sc) throws Exception;

    List<BoardDto> searchSelectPage(SearchCondition sc) throws Exception;

    int updateCommentCnt(Integer bno, int cnt);
}
