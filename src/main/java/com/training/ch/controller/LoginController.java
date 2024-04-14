package com.training.ch.controller;


import com.training.ch.domain.User;
import com.training.ch.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;

@Controller
@RequestMapping("/login")
public class LoginController {
    @Autowired
    UserServiceImpl userService;


    @GetMapping("/login")
    public String loginForm(){
        return "member/loginForm";
    }

    @PostMapping("/login")
    public String login(String id, String pwd, String toURL, boolean rememberId,
                        HttpServletRequest request, HttpServletResponse response) throws  Exception{
        //1. id, pwd 확인인
        if(!loginCheck(id, pwd)){
            String msg = URLEncoder.encode("아이디 또는 비밀번호가 일치하지 않습니다.", "UTF-8");
            return "redirect:/login/login?msg="+msg;
        }

        // 2-2. id와 pwd가 일치하면,
        HttpSession session = request.getSession();
        session.setAttribute("id", id);

        if(rememberId) {
            //  1. 쿠키를 생성
            Cookie cookie = new Cookie("id", id);
		    //  2. 응답에 저장
            response.addCookie(cookie);
        } else {
            // 1. 쿠키를 삭제
            Cookie cookie = new Cookie("id", id);
            cookie.setMaxAge(0); // 쿠키를 삭제
		    // 2. 응답에 저장
            response.addCookie(cookie);
        }

        //3. 홈으로 이동
        toURL = toURL==null || toURL.equals("") ? "/" : toURL;


        return "redirect:"+toURL;
    }


    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/";
    }


    @GetMapping("/idSearch")
    public String searchId(){
        return "member/searchId";
    }

    @ResponseBody
    @PostMapping("/idSearchPro")
    public String loginSearchIdPro(User user) throws Exception {
        String result = userService.idSearch(user);
        System.out.println("result = " + result);
        if(result==null){
            return "no";
        }else{
            return result.substring(0, result.length() - 4) + "****";
        }
    }

    @GetMapping("/pwdSearch")
    public String searchPwd(){
        return "member/searchPwd";
    }

    @PostMapping("/pwdSearchPro")
    public String searchPwdPro(User user) throws Exception {
        String result = userService.pwdSearch(user);
        System.out.println("result = " + result);
        if(result==null){
            return "no";
        }else{
            return result;
        }
    }

    private boolean loginCheck(String id, String pwd) {
        User user = null;

        try {
            user = userService.selectUser(id);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        return user!=null && user.getPwd().equals(pwd);
    }

}
