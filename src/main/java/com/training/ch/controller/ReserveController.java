package com.training.ch.controller;

import com.training.ch.service.ReserveServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/reserve")
public class ReserveController {
    @Autowired
    ReserveServiceImpl reserveService;

    @GetMapping("/reserve")
    public String reserve(){
        return "reservation/reserve";
    }

    @GetMapping("/test")
    public String test(){
        return "reservation/test";
    }



}
