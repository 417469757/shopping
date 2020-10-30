package com.amei.service.impl;

import com.amei.dao.UserDao;
import com.amei.pojo.User;
import com.amei.service.UserService;
import com.amei.utils.MD5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Service
@Transactional
public class UserServieImpl implements UserService {


    @Autowired
    private UserDao userDao;


    /*注册新用户*/
    @Override
    public int addUser(User user) {
        User user1 = userDao.selectByName(user.getLoginName());
        if (user1 == null ) {
            userDao.saveUser(user);
            return 1;
        } else {
            try {
                throw new Exception("用户已存在");
            } catch (Exception e) {
                e.printStackTrace();
            }
            return 0;
        }
    }

    //用户端登录
    @Override
    public User login(String loginName, String loginPass) throws Exception {

        System.out.println("=========loginNAme:" + loginName + "======");
        System.out.println("=========loginPass:" + loginPass + "======");
        User user1 = userDao.selectUserByName(loginName);
        System.out.println("user1================================" + user1);

        String loginPass1 = user1.getLoginPass();
        //MD5 与所登录的密码是否一致，就是所登录的密码是否与数据库中的MD5一致
        if (MD5Utils.getSaltverifyMD5(loginPass, loginPass1)) {
            return user1;
        } else {
            throw new Exception("用户名不存在或者密码错误!"); // 抛异常
        }
    }


    /*前端登录验证*/
//    @Override
//    public User selectByName(User user) throws Exception {
//        User user2 = userDao.selectByName(user.getLoginName());
//        if (user2 == null){
//            throw new Exception("用户名不存在，请重新登录");
//        }else if (!MD5Utils.getSaltverifyMD5(user.getLoginPass(),user2.getLoginPass())){
//            throw new Exception("用户名或密码错误，请重新登录");
//        }
//        return user2;
//    }

    /* 修改密码*/
    @Override
    public void updatePass(String oldPass, String newPass, Integer user_id) {
        User user = userDao.selectById(user_id);
        if (!MD5Utils.getSaltverifyMD5(oldPass, user.getLoginPass())) {
            try {
                throw new Exception("旧密码填写错误");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        userDao.updatePass(MD5Utils.getSaltMD5(newPass), user_id);
    }


    /*修改用户信息*/
    @Override
    public void updateUserInfoById(User user) {
        userDao.updateUserInfoById(user);
    }

    @Override
    public User selectById(Integer id) {
        return userDao.selectById(id);
    }

    /*修改头像*/
    @Override
    public void modifyHeadImg(CommonsMultipartFile file, HttpSession session) {
        // 获取上传的文件名
        String originalFileName = file.getOriginalFilename();
        System.out.println("上传的文件名:" + originalFileName);

        // 上传路径
        String uploadPath = session.getServletContext().getRealPath("/WEB-INF/upload/");

        //  保存到t_user表中的头像路径
        //  当天日期格式化：yyyyMMdd
        String time = new SimpleDateFormat("yyyyMMdd").format(new Date());
        String imgPath = time + File.separator + originalFileName;

        // 更新t_user表中head字段
        User user = (User) session.getAttribute("user");
        userDao.updateHeadByUserId(imgPath, user.getId());

        // 创建upload以及以年月日命名的文件夹
        File temp = new File(uploadPath, time);
        temp.mkdirs();

        // 上传文件
        try {
            file.transferTo(new File(uploadPath, imgPath));
        } catch (IOException e) {
            e.printStackTrace();
        }


    }

    //前端验证注册的用户是否是新用户
    @Override
    public User isExistUser(String login_name) {
        return userDao.isExistUser(login_name);
    }


}
