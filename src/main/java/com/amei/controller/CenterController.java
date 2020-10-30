package com.amei.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/center")
public class CenterController {
    /**
     * 跳转到center.jsp
     * @return
     */
    @RequestMapping("/showCenter")
    public  String showCenter(Model model){
        model.addAttribute("navIndex", 3);// 购物车索引
        return "center";
    }



}
