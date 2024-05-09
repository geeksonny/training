package com.training.ch.dao;

import com.training.ch.domain.EquipmentDto;
import com.training.ch.domain.SearchCondition;

import java.util.List;

public interface EquipDao {
    int getCount() throws Exception;

    List<EquipmentDto> selectEquipListAll() throws Exception;

    int searchResultCnt(SearchCondition sc) throws Exception;

    List<EquipmentDto> searchSelectPage(SearchCondition sc) throws Exception;

    EquipmentDto select(int eno) throws Exception;
}
