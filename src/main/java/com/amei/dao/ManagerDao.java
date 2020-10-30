package com.amei.dao;

import com.amei.pojo.Manager;
import org.apache.ibatis.annotations.Param;

public interface ManagerDao {
    Manager selectManager(@Param("loginName")String loginName, @Param("loginPass") String loginPass);
}
