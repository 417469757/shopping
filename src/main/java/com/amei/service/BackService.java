package com.amei.service;

import com.amei.pojo.Manager;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpSession;

public interface BackService {
    Manager login(String login_name, String login_pass) throws Exception;

    int addPro(String productName, String productPrice, String productTypeId, String productDes, CommonsMultipartFile file, HttpSession session);

    int updateProInfo(String proNo, String proName, String proPrice, int productTypeId);

    int addProductType(String productTypeName);

    String banProById(Integer banId);

    String banProTypeById(Integer banId);

    int updateProTypeInfo(String proTypeName,String typeId);
}
