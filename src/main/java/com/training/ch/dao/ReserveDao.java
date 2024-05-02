package com.training.ch.dao;

import com.training.ch.domain.ReserveDto;

import java.util.List;

public interface ReserveDao {
    int count() throws Exception;

    int insertReserve(ReserveDto reserveDto) throws Exception;

    ReserveDto selectReserve(String id) throws Exception;

    List<ReserveDto> selectReserveAll() throws Exception;

    List<ReserveDto> selectReserveIdAll(String id) throws Exception;

    int cancelUseCnt(int rno, String type, int reserve_state) throws Exception;
}
