package com.amei.dao;

import com.amei.pojo.User;
import org.apache.ibatis.annotations.Param;


public interface UserDao {
    void saveUser(User user);

    //根据用户名和密码查找user
    User selectByNameAndPass(@Param("loginName") String loginName,@Param("loginPass") String loginPass);

    User selectByName(String loginName);

    //根据用户名查找user
    User findUser(User user);

    //修改密码
    void updatePass(@Param("newPass") String newPass,@Param("id")Integer id);

    void updateUserInfoById(User user);

    User selectById(Integer id);

    void updateHeadByUserId(@Param("imgPath") String imgPath,@Param("userId") Integer userId);

    User isExistUser(String login_name);

    User selectUserByName(String loginName);
}

