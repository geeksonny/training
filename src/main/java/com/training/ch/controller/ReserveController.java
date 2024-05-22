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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

        return "reservation/reserve";
    }

    @PostMapping("/reserve")
    public String reservePro(Integer page, Integer pageSize, Integer eno, ReserveDto reserveDto,
                             Model m, HttpSession session,RedirectAttributes rattr){
        String id = (String)session.getAttribute("id");

        if(id==null){
            m.addAttribute("msg", "RESERVE_ERR");
            return "member/loginForm";
        }
        reserveDto.setId(id);

        try {
            EquipmentDto equipmentDto = equipService.select(eno);


            // 1. 사용자가 선택한 예약 시간대에 이미 예약이 있는지 확인
            if (reserveService.isAlreadyReserved(reserveDto)>=1) {
                m.addAttribute(equipmentDto);
                m.addAttribute("eno", eno);
                m.addAttribute("page",page);
                m.addAttribute("pageSize", pageSize);
                m.addAttribute("msg", "ALREADY_RESERVED");
                return "reservation/reserve";
            }

            // 2. 만약 해당 시간대에 사용자가 이미 다른 기구를 예약한 경우에도 예약을 막아야 함
            if (reserveService.otherReserved(reserveDto)>=1) {
                m.addAttribute(equipmentDto);
                m.addAttribute("eno", eno);
                m.addAttribute("page",page);
                m.addAttribute("pageSize", pageSize);
                m.addAttribute("msg", "OTHER_RESERVATION");
                return "reservation/reserve";
            }

            int rowCnt = reserveService.reserve(reserveDto);
            rattr.addFlashAttribute("msg", "RESERVE_OK");
            return "redirect:/reserve/list";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("reserveDto", reserveDto);
            m.addAttribute("msg", "RESERVE_ERR");
            return "reservation/reserve";
        }
    }

    @GetMapping("/equipments")
    public String getEquipmentsByCategory(Integer eCategory, @RequestParam(defaultValue = "1") int page, Model m) {
        // 카테고리에 따른 기구 목록을 가져오는 서비스 호출
        List<EquipmentDto> equipments = null;
        try {
            int pageSize = 8;
            SearchCondition sc = new SearchCondition(page, pageSize, "", "");
            int totalCnt = equipService.getResultCnt(eCategory);
            PageHandler pageHandler = new PageHandler(totalCnt, sc);

            equipments = equipService.selectEquipCategory(eCategory, sc);
            m.addAttribute("eCategory", eCategory);
            m.addAttribute("list", equipments);
            m.addAttribute("ph", pageHandler);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "reservation/equipList";
    }


}
