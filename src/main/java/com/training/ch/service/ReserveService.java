package com.training.ch.service;

import com.training.ch.domain.ReserveDto;

import java.util.List;

public interface ReserveService {
    int getCount() throws Exception;

    int reserve(ReserveDto reserveDto) throws Exception;

    ReserveDto selectReserve(String id) throws Exception;

    List<ReserveDto> selectReserveIdAll(String id) throws Exception;

    int cancelUseCnt(int rno, String type, int reserve_state) throws Exception;

    int isAlreadyReserved(ReserveDto reserveDto) throws Exception;

    int otherReserved(ReserveDto reserveDto) throws Exception;
}
