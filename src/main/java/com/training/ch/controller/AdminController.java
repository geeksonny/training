package com.training.ch.controller;

import com.training.ch.domain.*;
import com.training.ch.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/mypage")
public class AdminController {

    @Autowired
    UserServiceImpl userService;
    @Autowired
    BoardServiceImpl boardService;
    @Autowired
    ReserveService reserveService;
    @Autowired
    CommentService commentService;

    @GetMapping("")
    public String myPage(HttpSession session, Model m, SearchCondition sc){
        String id = (String) session.getAttribute("id");
        try {
            //나의 정보
            User user = userService.selectUser(id);
            m.addAttribute("user", user);

            //운동 예약 내역
            List<ReserveDto> reserveList = reserveService.selectReserveIdAll(id);
            List<ReserveDto> curReserveList = reserveService.selectCurrentReserve(id);
            List<ReserveDto> canceledReserveList = reserveService.selectCanceledReserve(id);
            List<ReserveDto> comReserveList = reserveService.selectCompletedReserve(id);
            // 현재 예약 내역(개)
            m.addAttribute("countReserve", reserveService.countReserve(id));
            m.addAttribute("curReserveList", curReserveList);
            // 예약 취소 내역(개)
            m.addAttribute("countCanceled", reserveService.countCanceledReserve(id));
            m.addAttribute("canceledReserveList", canceledReserveList);
            // 사용 완료 내역(개)
            m.addAttribute("countCompleted", reserveService.countCompletedReserve(id));
            m.addAttribute("comReserveList", comReserveList);
            // 총예약 내역(개)
            m.addAttribute("countReservation", reserveService.countReservation(id));
            m.addAttribute("reserveList", reserveList);


            //나의 글

            Map map = new HashMap();
            map.put("offset", sc.getOffset());
            map.put("pageSize", sc.getPageSize());
            map.put("writer", id);
            map.put("option", sc.getOption());
            map.put("keyword", sc.getKeyword());

            int totalCnt = boardService.countWrite(map);
            PageHandler pageHandler = new PageHandler(totalCnt, sc);

            List<BoardDto> boardList = boardService.getPage(map);

            m.addAttribute("boardList", boardList);
            m.addAttribute("countWrite", totalCnt);
            m.addAttribute("ph", pageHandler);

            Instant startOfToday = LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant();
            m.addAttribute("startOfToday", startOfToday.toEpochMilli());

            //나의 댓글글
            List<CommentDto> commentList = commentService.getList(id);
            m.addAttribute("commentList", commentList);
            m.addAttribute("countComment", commentService.countComment(id));


        } catch (Exception e) {
            e.printStackTrace();
        }


        return "mypage";
    }


    @GetMapping("/admin")
    public String admin(){
        return "admin";
    }

}
