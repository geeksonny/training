package com.training.ch.service;

import com.training.ch.dao.ReserveDao;
import com.training.ch.domain.ReserveDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReserveServiceImpl implements ReserveService {
    @Autowired
    ReserveDao reserveDao;

    @Override
    public int getCount() throws Exception{
        return reserveDao.count();
    }

    @Override
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
}
