package com.training.ch.controller;

import com.training.ch.domain.BoardDto;
import com.training.ch.domain.PageHandler;
import com.training.ch.domain.SearchCondition;
import com.training.ch.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    BoardService boardService;
    @Resource(name = "uploadPath")
    private String uploadPath;


    @GetMapping("/board")
    public String board(Model m, HttpServletRequest request) {
        if(!loginCheck(request))
            return "redirect:/login/login?toURL="+request.getRequestURL();
        m.addAttribute("mode","new");
        return "board";
    }

    @PostMapping("/write")
    public String write(BoardDto boardDto, Model m, HttpSession session, MultipartFile file){
        String writer = (String)session.getAttribute("id");
        boardDto.setWriter(writer);
        String filename = "";
        try {
            if(file==null || file.isEmpty()){
                filename = "dumbbell.jpg";
            }else {
                UUID uuid = UUID.randomUUID();
                filename = uuid.toString()+"_"+file.getOriginalFilename();

                File uploadFile = new File(uploadPath, filename);
                FileCopyUtils.copy(file.getBytes(),uploadFile);
            }
            boardDto.setBfile(filename);
            int rowCnt = boardService.write(boardDto);

            return "redirect:/board/list";
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("boardDto", boardDto);
            return "board";
        }

    }

    @GetMapping("/list")
    public String list(SearchCondition sc, Model m){
        try {
            int totalCnt = boardService.getSearchResultCnt(sc);
            PageHandler pageHandler = new PageHandler(totalCnt, sc);

            List<BoardDto> list = boardService.getSearchResultPage(sc);
            m.addAttribute("list", list);
            m.addAttribute("ph", pageHandler);

            Instant startOfToday = LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant();
            m.addAttribute("startOfToday", startOfToday.toEpochMilli());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "boardList";
    }

    @GetMapping("/read")
    public String read(Integer bno, Integer page, Integer pageSize, Model m){
        try {
            BoardDto boardDto = boardService.read(bno);
            m.addAttribute(boardDto);
            m.addAttribute("page", page);
            m.addAttribute("pageSize", pageSize);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "board";
    }

    @PostMapping("/modify")
    public String modify(Integer page, Integer pageSize, BoardDto boardDto, Model m, HttpSession session, RedirectAttributes rattr){
        String writer = (String)session.getAttribute("id");
        boardDto.setWriter(writer);
        try {
            int rowCnt = boardService.modify(boardDto);
            if(rowCnt!=1) throw new Exception("Modify failed");

            rattr.addFlashAttribute("page", page);
            rattr.addFlashAttribute("pageSize", pageSize);

            return "redirect:/board/list";
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("boardDto", boardDto);
            return "board";
        }
    }

    @PostMapping("/delete")
    public String delete(Integer bno, Integer page, Integer pageSize, Model m, HttpSession session, RedirectAttributes rattr){
        String writer = (String)session.getAttribute("id");
        try {
            rattr.addFlashAttribute("page", page);
            rattr.addFlashAttribute("pageSize", pageSize);

            int rowCnt = boardService.remove(bno, writer);

            if(rowCnt!=1) {
                m.addAttribute("msg", "Delete Error");
                throw new Exception("Delete Error");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/board/list";
    }


    private boolean loginCheck(HttpServletRequest request) {
        // 1. 세션을 얻어서
        HttpSession session = request.getSession();
        // 2. 세션에 id가 있는지 확인, 있으면 true를 반환
        return session.getAttribute("id")!=null;
    }



}
