package com.training.ch.controller;

import com.training.ch.domain.User;
import com.training.ch.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RestController
public class AjaxController {

    @Autowired
    private UserServiceImpl userService;


    //유저 아이디 찾기
    @PostMapping("/login/idSearch")
    public ResponseEntity<String> idSearch(User user, HttpServletRequest request){
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        String result="";
        try {
            user.setName(name);
            user.setEmail(email);
            String id = userService.idSearch(user);

            if(id!=null){
                result=id;
            }else{
                result="no";
            }
            return new ResponseEntity<String>(result, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>(result, HttpStatus.BAD_REQUEST);
        }
    }

    //유저 비밀번호 찾기
    @PostMapping("/login/pwdSearch")
    public ResponseEntity<String> pwdSearch(User user, HttpServletRequest request){
        String id = request.getParameter("id");
        String email = request.getParameter("email");

        String result="";
        try {
            user.setId(id);
            user.setEmail(email);

            String pwd = userService.pwdSearch(user);


            if(pwd!=null){
                result=pwd;
            }else{
                result="no";
            }
            return new ResponseEntity<String>(result, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>(result, HttpStatus.BAD_REQUEST);
        }
    }

    // 유저 비밀번호 수정
    @PostMapping("/login/pwdModify")
    public ResponseEntity<String> pwdModify(User user, HttpServletRequest request){
        String id = request.getParameter("userId");
        String email = request.getParameter("userEmail");

        String result="";
        try {
            user.setId(id);
            user.setEmail(email);
            int pwd = userService.pwdMod(user);

            return new ResponseEntity<String>("MOD_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("MOD_ERR", HttpStatus.BAD_REQUEST);
        }
    }

    // 아이디 중복검사
    @PostMapping( "/member/idDupCheck")
    public ResponseEntity<String> loginIdCheck(HttpServletRequest request) {
        String id=request.getParameter("id");
        String result="";
        User user = null;
        try {
            user = userService.selectUser(id);
            if(user!=null) {	// 아이디 중복
                result="iddup";
            }else {				// 아이디 사용가능
                result="idok";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        ResponseEntity<String> entity = new ResponseEntity<String>(result,HttpStatus.OK);
        return entity;
    }

    // 이메일 중복검사
    @PostMapping("/member/mailDupCheck")
    public ResponseEntity<String> loginEmailCheck(HttpServletRequest request) {
        String email=request.getParameter("email");
        String result="";
        User user = null;
        try {
            user = userService.checkUserEmail(email);
            if(user!=null) {	// 이메일 중복
                result="emaildup";
            }else {				// 이메일 사용가능
                result="emailok";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        ResponseEntity<String> entity = new ResponseEntity<String>(result,HttpStatus.OK);
        return entity;
    }

}

