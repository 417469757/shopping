package com.amei.controller;

import com.alibaba.fastjson.JSONObject;
import com.amei.pojo.User;
import com.amei.service.UserService;
import com.amei.utils.MD5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;

@Controller
@RequestMapping("/user")
public class UserController {

    private Logger logger = Logger.getLogger(String.valueOf(UserController.class));

    @Autowired
    private UserService userService;


//    //前端注册验证
//    @RequestMapping("/checkNewUser")
//    public String checkNewUser(@RequestParam("registryName") String login_name) {
//
//        System.out.println("======registryName============" + login_name);
//        User oneUser = userService.isExistUser(login_name);
//        if (oneUser == null) {
//            //用户没有注册过
//            return "true";
//        } else {
//            //用户注册过
//            return "false";
//        }
//    }

    //后端注册
    @RequestMapping(value = "/doRegistry", method = RequestMethod.POST, produces = "text/html;charset=UTF-8;")
    public String DoRegistry(@RequestParam("username") String username,
                             @RequestParam("registryName") String loginName,
                             @RequestParam("login_pass") String loginPass,
                             @RequestParam("phone") String phone,
                             @RequestParam("address") String address) throws Exception {
        User user = new User();
        user.setAddress(address);
        user.setUsername(username);
        user.setLoginName(loginName);
        String saltMD5 = MD5Utils.getSaltMD5(loginPass);
        user.setLoginPass(saltMD5);
        user.setPhone(phone);
        int i = userService.addUser(user);

        if (i == 1) {
            return "forward:/showMain";     // 转发到     /showMain请求
        } else
            throw new Exception("false,用户已存在");
    }

    //前端登录验证
//    @RequestMapping("/checkLogin")
//    public String checkLogin(@RequestParam("registryName") String login_name,
//                             @RequestParam("login_pass") String login_pass) {
//        User user = new User();
//        user.setUsername(login_name);
//        user.setLoginPass(login_pass);
//        System.out.println("============check login========="+login_name);
//        System.out.println("============check login========="+login_pass);
//        User oneUser = userService.selectByName(user);
//        if (oneUser != null) {
//            return   "true";
//        } else {
//            return  "false";
//        }
//    }

    //客户端登录
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@RequestParam("login_name") String login_name,
                        @RequestParam("login_pass") String login_pass,
                        Model model, HttpSession session) {

        // 捕捉异常
        try {
            User user = userService.login(login_name, login_pass);

            // 成登录后 把用户信息存入session
            session.setAttribute("user", user);

        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            e.printStackTrace();
        }
        return "forward:/showMain";     // 转发到     /showMain请求
    }


    //客户端退出登录
    @RequestMapping("/loginOut")
    public String loginOut(HttpSession session) {

        session.removeAttribute("user");

        //  return "main";
        return "redirect:/showMain";
    }


    //修改密码  , produces = "text/html;charset=utf-8"
    @RequestMapping(value = "/updatePass", method = RequestMethod.POST)
    public String updatePass(@RequestParam("newPass") String newPass,
                             @RequestParam("oldPass") String oldPass,
                             HttpSession session) {

        logger.info("接收参数:" + newPass + "  " + oldPass);
        User user = (User) session.getAttribute("user");

        try {
            userService.updatePass(oldPass, newPass, user.getId());
            System.out.println(user.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/showMain";
    }


    @RequestMapping(value = "/modifyUserInfo", method = RequestMethod.POST)
    public String modifyUserInfo(User user, HttpSession session) {
        System.out.println("===================" + user);

        userService.updateUserInfoById(user);

        /* 修改成功后，修改session中用户*/
        // 先要根据id查找用户信息
        user = userService.selectById(user.getId());
        session.setAttribute("user", user);

        return "redirect:/center/showCenter";
    }


    @RequestMapping(value = "/modifyHeadImg", method = RequestMethod.POST)
    public String modifyHeadImg(@RequestParam("file") CommonsMultipartFile file,
                                HttpSession session) throws IOException {
        System.out.println("===================file=$$$$$$$$$$$"+file);
        userService.modifyHeadImg(file, session);
        User user = (User) session.getAttribute("user");
        User user1 = userService.selectById(user.getId());
        session.setAttribute("user",user1);
        return "redirect:/center/showCenter";
    }

    @RequestMapping(value = "/modifyImages", method = RequestMethod.POST)
    public String modifyImages(@RequestParam("fileImages") CommonsMultipartFile file, HttpSession session) throws IOException {
        System.out.println("===================file=$$$$$$$$$$$"+file);
        userService.modifyHeadImg(file, session);
        return "redirect:/center/showCenter";
    }


}

