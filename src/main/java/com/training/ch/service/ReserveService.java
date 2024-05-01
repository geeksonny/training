package com.training.ch.service;

import com.training.ch.dao.ReserveDao;
import com.training.ch.domain.ReserveDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReserveService {
    @Autowired
    ReserveDao reserveDao;

    public int getCount() throws Exception{
        return reserveDao.count();
    }

    public int reserve(ReserveDto reserveDto) throws Exception{
        return reserveDao.insertReserve(reserveDto);
    }

    public ReserveDto selectReserve(String id) throws Exception{
        return reserveDao.selectReserve(id);
    }

    public List<ReserveDto> selectReserveIdAll(String id) throws Exception{
        return reserveDao.selectReserveIdAll(id);
    }

}
