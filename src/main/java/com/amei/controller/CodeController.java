//package com.amei.controller;
//
//import com.amei.utils.CreateCodeUtil;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.IOException;
//
//@Controller
//@RequestMapping("/code")
//public class CodeController {
//
//    @RequestMapping("/createCode")
//    public void  createCode(HttpSession session, HttpServletResponse response) throws IOException {
//        CreateCodeUtil.createCode(session, response);
//    }
//
//
//    /**
//     *
//     * @param code   自己输入的code
//     * @return
//     */
//    @RequestMapping("/checkCode")
//    @ResponseBody       // 返回文本
//    public  String checkCode(@RequestParam("code") String code,HttpSession session){
//       // session中保存的验证码
//       String randomCode =  session.getAttribute("randomCode").toString();
//
//       if(code.equalsIgnoreCase(randomCode)){
//           return "true";
//       }else{
//          return "false";
//       }
//    }
//
//}
