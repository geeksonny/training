package com.training.ch.dao;

import com.training.ch.domain.CommentDto;

import java.util.List;

public interface CommentDao {
    int count(Integer bno) throws Exception
    ;

    int deleteAll(Integer bno)
    ;

    int delete(Integer cno, String commenter) throws Exception
    ;

    int insert(CommentDto dto) throws Exception
    ;

    List<CommentDto> selectAll(Integer bno) throws Exception
    ;

    CommentDto select(Integer cno) throws Exception
    ;

    int update(CommentDto dto) throws Exception
    ;

    List<CommentDto> getList(String commenter) throws Exception;

    int countComment(String commenter) throws Exception;
}
