package com.training.ch.domain;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.Objects;

public class ReserveDto {
    private int rno;        // 예약번호
    private String id;      // 사용자
    private String type;    // 기구 종류

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date startTime; // 예약 시작 시간
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date endTime;   // 예약 종료 시간

    private int use_cnt;     // 이용횟수
    private int reserve_state; // 0: 예약완료 1: 예약취소 2:사용완료


    public ReserveDto(){}

    public ReserveDto(int rno, String id, String type, Date startTime, Date endTime, int use_cnt, int reserve_state) {
        this.rno = rno;
        this.id = id;
        this.type = type;
        this.startTime = startTime;
        this.endTime = endTime;
        this.use_cnt = use_cnt;
        this.reserve_state = reserve_state;
    }

    @Override
    public String toString() {
        return "ReserveDto{" +
                "rno=" + rno +
                ", id='" + id + '\'' +
                ", type='" + type + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", use_cnt=" + use_cnt +
                ", reserve_state='" + reserve_state + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ReserveDto that = (ReserveDto) o;
        return rno == that.rno && use_cnt == that.use_cnt && Objects.equals(id, that.id) && Objects.equals(type, that.type) && Objects.equals(startTime, that.startTime) && Objects.equals(endTime, that.endTime) && Objects.equals(reserve_state, that.reserve_state);
    }

    @Override
    public int hashCode() {
        return Objects.hash(rno, id, type, startTime, endTime, use_cnt, reserve_state);
    }

    public int getRno() {
        return rno;
    }

    public void setRno(int rno) {
        this.rno = rno;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public int getUse_cnt() {
        return use_cnt;
    }

    public void setUse_cnt(int useCnt) {
        this.use_cnt = use_cnt;
    }

    public int getReserve_state() {
        return reserve_state;
    }

    public void setReserve_state(int reserve_state) {
        this.reserve_state = reserve_state;
    }
}
