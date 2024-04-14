package com.training.ch.controller;

import com.training.ch.domain.User;
import com.training.ch.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
public class AjaxController {

    @Autowired
    private UserServiceImpl userService;

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
            user.setName(id);
            user.setEmail(email);
            String pwd = userService.idSearch(user);

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


}
