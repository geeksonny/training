package com.training.ch.dao;

import com.training.ch.domain.BoardDto;
import com.training.ch.domain.SearchCondition;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class BoardDaoImplTest {

    @Autowired
    private BoardDao boardDao;

    @Test
    public void count() throws Exception{
        boardDao.deleteAll();
        assertTrue(boardDao.count()==0);

        BoardDto boardDto = new BoardDto("no title", "no content", "asdf");
        assertTrue(boardDao.insert(boardDto)==1);
        assertTrue(boardDao.count()==1);

        assertTrue(boardDao.insert(boardDto)==1);
        assertTrue(boardDao.count()==2);
    }

    @Test
    public void deleteAll() {
    }

    @Test
    public void delete() {
    }

    @Test
    public void insert() {
    }

    @Test
    public void selectAll() {
    }

    @Test
    public void select() {
    }

    @Test
    public void selectPage() {
    }

    @Test
    public void update() {
    }

    @Test
    public void increaseViewCnt() {
    }

    @Test
    public void searchResultCnt() throws Exception {
        boardDao.deleteAll();
        for(int i = 1; i <=20; i++){
            BoardDto boardDto = new BoardDto("asdf"+i, "title"+i,"asdfasdf"+i);
            boardDao.insert(boardDto);
        }
        SearchCondition sc = new SearchCondition(1, 10, "title2", "T"); //title2%
        int cnt = boardDao.searchResultCnt(sc);
        System.out.println("cnt = " + cnt);
        assertTrue(cnt==2); // 1~20, title2, title20

        sc = new SearchCondition(1, 10, "asdf2", "W"); //asdf2%
        cnt = boardDao.searchResultCnt(sc);
        System.out.println("cnt = " + cnt);
        assertTrue(cnt==2); // 1~20, title2, title20
    }

    @Test
    public void searchSelectPage() throws Exception {
        boardDao.deleteAll();
        for(int i = 1; i <=20; i++){
            BoardDto boardDto = new BoardDto("title"+i, "asdfasdf","asdf"+i);
            boardDao.insert(boardDto);
        }
        SearchCondition sc = new SearchCondition(1, 10, "title2", "T"); //title2%
        List<BoardDto> list = boardDao.searchSelectPage(sc);
        System.out.println("list = " + list);
        assertTrue(list.size()==2); // 1~20, title2, title20

        sc = new SearchCondition(1, 10, "asdf2", "W"); //asdf2%
        list = boardDao.searchSelectPage(sc);
        System.out.println("list = " + list);
        assertTrue(list.size()==2); // 1~20, asdf2, asdf20
    }

    @Test
    public void updateCommentCnt() {
    }
}