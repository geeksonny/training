package com.training.ch.controller;

import com.training.ch.domain.User;
import com.training.ch.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RestController
public class AjaxController {

    @Autowired
    private UserServiceImpl userService;
    @Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;

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


}

