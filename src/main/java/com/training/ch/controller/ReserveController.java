package com.training.ch.controller;

import com.training.ch.domain.EquipmentDto;
import com.training.ch.domain.PageHandler;
import com.training.ch.domain.SearchCondition;
import com.training.ch.service.EquipServiceImpl;
import com.training.ch.service.ReserveServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/reserve")
public class ReserveController {
    @Autowired
    ReserveServiceImpl reserveService;
    @Autowired
    EquipServiceImpl equipService;

    @GetMapping("/reserve")
    public String reserve(){
        return "reservation/reserve";
    }

    @GetMapping("/test")
    public String test(SearchCondition sc, Model m){

        try {
            int totalCnt = equipService.getSearchResultCnt(sc);
            PageHandler pageHandler = new PageHandler(totalCnt, sc);
            int pageSize = 8;
            sc.setPageSize(pageSize);

            List<EquipmentDto> list = equipService.getSearchResultPage(sc);
            m.addAttribute("list", list);
            m.addAttribute("ph", pageHandler);


        } catch (Exception e) {
            e.printStackTrace();
        }


        return "reservation/test";
    }



}
