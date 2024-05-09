package com.training.ch.controller;

import com.training.ch.domain.*;
import com.training.ch.service.EquipServiceImpl;
import com.training.ch.service.ReserveServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/reserve")
public class ReserveController {
    @Autowired
    ReserveServiceImpl reserveService;
    @Autowired
    EquipServiceImpl equipService;

    @GetMapping("/list")
    public String reserve(SearchCondition sc, Model m){
        try {
            int totalCnt = equipService.getSearchResultCnt(sc);
            PageHandler pageHandler = new PageHandler(totalCnt, sc);
            int pageSize = 8;
            sc.setPageSize(pageSize);
            pageHandler.doPaging(totalCnt, sc);

            List<EquipmentDto> list = equipService.getSearchResultPage(sc);
            m.addAttribute("list", list);
            m.addAttribute("ph", pageHandler);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "reservation/reserveList";
    }

    @GetMapping("/select")
    public String reserveDetail(Integer eno, Integer page, Integer pageSize, Model m){
        try {
            EquipmentDto equipmentDto = equipService.select(eno);
            m.addAttribute(equipmentDto);
            m.addAttribute("page", page);
            m.addAttribute("pageSize", pageSize);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "reservation/test2";
    }

    @PostMapping("reserve")
    public String reservePro(ReserveDto reserveDto, Model m, HttpSession session, HttpServletRequest request){
        String id = (String)session.getAttribute("id");
        if(id==null){
            return "member/loginForm";
        }
        reserveDto.setId(id);

        try {
            int rowCnt = reserveService.reserve(reserveDto);

            m.addAttribute("msg", "RESERVE_OK");

            return "redirect:/reserve/list";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("reserveDto", reserveDto);
            m.addAttribute("msg", "RESERVE_ERR");
            return "reservation/test2";
        }



    }



}
