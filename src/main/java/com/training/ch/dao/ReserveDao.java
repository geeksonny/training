package com.training.ch.dao;

import com.training.ch.domain.ReserveDto;

import java.util.List;

public interface ReserveDao {
    int insertReserve(ReserveDto reserveDto) throws Exception;

    ReserveDto selectReserve(String id) throws Exception;

    List<ReserveDto> selectReserveAll() throws Exception;

    List<ReserveDto> selectReserveIdAll(String id) throws Exception;

    int cancelUseCnt(int rno, String type, int reserve_state) throws Exception;

    int isAlreadyReserved(ReserveDto reserveDto) throws Exception;

    int otherReserved(ReserveDto reserveDto) throws Exception;

    int canceledReserve(ReserveDto reserveDto) throws Exception;

    int countReserve(String id) throws Exception;

    int countCanceledReserve(String id) throws Exception;

    int countCompletedReserve(String id) throws Exception;

    int countReservation(String id) throws Exception;

    List<ReserveDto> selectCurrentReserve(String id) throws Exception;

    List<ReserveDto> selectCanceledReserve(String id) throws Exception;

    List<ReserveDto> selectCompletedReserve(String id) throws Exception;
}
