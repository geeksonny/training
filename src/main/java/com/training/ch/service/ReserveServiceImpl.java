package com.training.ch.service;

import com.training.ch.dao.ReserveDao;
import com.training.ch.domain.ReserveDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ReserveServiceImpl implements ReserveService {
    @Autowired
    ReserveDao reserveDao;

    @Override
    @Transactional
    public int reserve(ReserveDto reserveDto) throws Exception{
        return reserveDao.insertReserve(reserveDto);
    }

    @Override
    public ReserveDto selectReserve(String id) throws Exception{
        return reserveDao.selectReserve(id);
    }

    @Override
    public List<ReserveDto> selectReserveIdAll(String id) throws Exception{
        return reserveDao.selectReserveIdAll(id);
    }

    @Override
    public int cancelUseCnt(int rno, String type, int reserve_state) throws Exception{
        return reserveDao.cancelUseCnt(rno, type, reserve_state);
    }

    @Override
    public int isAlreadyReserved(ReserveDto reserveDto) throws Exception {
        return reserveDao.isAlreadyReserved(reserveDto);
    }

    @Override
    public int otherReserved(ReserveDto reserveDto) throws Exception {
        return reserveDao.otherReserved(reserveDto);
    }
    @Override
    public int canceledReserve(ReserveDto reserveDto) throws Exception {
        return reserveDao.canceledReserve(reserveDto);
    }

    @Override
    public int countReserve(String id) throws Exception{
        return reserveDao.countReserve(id);
    }

    @Override
    public int countCanceledReserve(String id) throws Exception{
        return reserveDao.countCanceledReserve(id);
    }

    @Override
    public int countCompletedReserve(String id) throws Exception{
        return reserveDao.countCompletedReserve(id);
    }

    @Override
    public int countReservation(String id) throws Exception{
        return reserveDao.countReservation(id);
    }


    @Override
    public List<ReserveDto> selectCurrentReserve(String id) throws Exception{
        return reserveDao.selectCurrentReserve(id);
    }

    @Override
    public List<ReserveDto> selectCanceledReserve(String id) throws Exception{
        return reserveDao.selectCanceledReserve(id);
    }

    @Override
    public List<ReserveDto> selectCompletedReserve(String id) throws Exception{
        return reserveDao.selectCompletedReserve(id);
    }





}
