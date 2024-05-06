package com.training.ch.service;

import com.training.ch.dao.EquipDao;
import com.training.ch.domain.BoardDto;
import com.training.ch.domain.EquipmentDto;
import com.training.ch.domain.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EquipServiceImpl implements EquipService {

    @Autowired
    EquipDao equipDao;


    @Override
    public int getCount() throws Exception{
        return equipDao.getCount();
    }

    @Override
    public List<EquipmentDto> selectEquipListAll() throws Exception{
        return equipDao.selectEquipListAll();
    }


    @Override
    public int getSearchResultCnt(SearchCondition sc) throws Exception {
        return equipDao.searchResultCnt(sc);
    }

    @Override
    public List<EquipmentDto> getSearchResultPage(SearchCondition sc) throws Exception {
        return equipDao.searchSelectPage(sc);
    }




}
