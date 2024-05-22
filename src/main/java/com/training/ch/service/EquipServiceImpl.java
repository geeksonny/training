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
    public List<EquipmentDto> getResultPage(SearchCondition sc) throws Exception {
        return equipDao.searchSelectPage(sc);
    }

    @Override
    public EquipmentDto select(int eno) throws Exception {
        return equipDao.select(eno);
    }

    @Override
    public List<EquipmentDto> selectEquipCategory(int eCategory, SearchCondition sc) throws Exception {
        return equipDao.selectEquipCategory(eCategory, sc);
    }

    @Override
    public int getResultCnt(int eCategory) throws Exception {
        return equipDao.getResultCnt(eCategory);
    }

    @Override
    public int getSearchResultCnt(SearchCondition sc) throws Exception {
        return equipDao.getSearchResultCnt(sc);
    }

    @Override
    public List<EquipmentDto> getSearchResultPage(SearchCondition sc) throws Exception{
        return equipDao.getSearchResultPage(sc);
    }


}
