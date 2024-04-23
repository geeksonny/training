package com.training.ch.controller;

import com.training.ch.domain.User;
import com.training.ch.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
@RequestMapping("/register")
public class RegisterController {

    @Autowired
    UserServiceImpl userService;

    @Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;



    @GetMapping("/test")
    public String test(){
        return "member/insertTest";
    }

    @GetMapping("/add")
    public String register(){
        return "member/registerForm";
    }

    @PostMapping("/add")
    public String save(User user){
        try {
            user.setPwd(bcryptPasswordEncoder.encode(user.getPwd()));
            userService.registerUser(user);
            return "redirect:/login/login";

        } catch (Exception e) {
            e.printStackTrace();
            return "index";
        }
    }


}
