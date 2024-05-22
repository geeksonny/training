package com.training.ch.service;

import com.training.ch.domain.EquipmentDto;
import com.training.ch.domain.SearchCondition;

import java.util.List;

public interface EquipService {

    List<EquipmentDto> getResultPage(SearchCondition sc) throws Exception;

    EquipmentDto select(int eno) throws Exception;

    List<EquipmentDto> selectEquipCategory(int eCategory, SearchCondition sc) throws Exception;

    int getResultCnt(int eCategory) throws Exception;

    int getSearchResultCnt(SearchCondition sc) throws Exception;

    List<EquipmentDto> getSearchResultPage(SearchCondition sc) throws Exception;
}
