package com.training.ch.service;

import com.training.ch.domain.EquipmentDto;
import com.training.ch.domain.SearchCondition;

import java.util.List;

public interface EquipService {
    int getCount() throws Exception;

    List<EquipmentDto> selectEquipListAll() throws Exception;

    int getSearchResultCnt(SearchCondition sc) throws Exception;

    List<EquipmentDto> getSearchResultPage(SearchCondition sc) throws Exception;
}
