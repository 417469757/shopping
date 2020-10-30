package com.amei.service;

import com.amei.pojo.User;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpSession;

public interface UserService {

    int addUser(User user);


    User login(String loginName, String loginPass) throws Exception;

    void updatePass(String oldPass, String newPass, Integer id);

    void updateUserInfoById(User user);

    User selectById(Integer id);

    void modifyHeadImg(CommonsMultipartFile file, HttpSession session);

    User isExistUser(String login_name);
}
