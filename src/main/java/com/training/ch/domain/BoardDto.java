package com.training.ch.domain;

import java.util.Date;
import java.util.Objects;

public class BoardDto {
    private Integer bno;
    private String writer;
    private String title;
    private String content;
    private int view_cnt;
    private int comment_cnt;
    private Date reg_date;
    private Date up_date;
    private String bfile;

    @Override
    public String toString() {
        return "BoardDto{" +
                "bno=" + bno +
                ", writer='" + writer + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", view_cnt=" + view_cnt +
                ", comment_cnt=" + comment_cnt +
                ", reg_date=" + reg_date +
                ", up_date=" + up_date +
                ", bfile='" + bfile + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        BoardDto boardDto = (BoardDto) o;
        return view_cnt == boardDto.view_cnt && comment_cnt == boardDto.comment_cnt && Objects.equals(bno, boardDto.bno) && Objects.equals(writer, boardDto.writer) && Objects.equals(title, boardDto.title) && Objects.equals(content, boardDto.content) && Objects.equals(reg_date, boardDto.reg_date) && Objects.equals(up_date, boardDto.up_date) && Objects.equals(bfile, boardDto.bfile);
    }

    @Override
    public int hashCode() {
        return Objects.hash(bno, writer, title, content, view_cnt, comment_cnt, reg_date, up_date, bfile);
    }

    public String getBfile() {
        return bfile;
    }

    public void setBfile(String bfile) {
        this.bfile = bfile;
    }

    public BoardDto(){}

    public BoardDto(String writer, String title, String content) {
        this.writer = writer;
        this.title = title;
        this.content = content;
    }

    public Integer getBno() {
        return bno;
    }

    public void setBno(Integer bno) {
        this.bno = bno;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getView_cnt() {
        return view_cnt;
    }

    public void setView_cnt(int view_cnt) {
        this.view_cnt = view_cnt;
    }

    public int getComment_cnt() {
        return comment_cnt;
    }

    public void setComment_cnt(int comment_cnt) {
        this.comment_cnt = comment_cnt;
    }

    public Date getReg_date() {
        return reg_date;
    }

    public void setReg_date(Date reg_date) {
        this.reg_date = reg_date;
    }

    public Date getUp_date() {
        return up_date;
    }

    public void setUp_date(Date up_date) {
        this.up_date = up_date;
    }
}
