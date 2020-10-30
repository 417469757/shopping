package com.amei.service.impl;

import com.amei.dao.ManagerDao;
import com.amei.dao.ProductDao;
import com.amei.dao.ProductTypeDao;
import com.amei.pojo.Manager;
import com.amei.service.BackService;
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
public class BackServiceImpl implements BackService {

    @Autowired
    private ManagerDao managerDao;

    @Autowired
    private ProductDao productDao;

    @Autowired
    private ProductTypeDao productTypeDao;


    @Override
    public Manager login(String login_name, String login_pass) throws Exception {

        System.out.println("=========loginNAme:" + login_name + "======");
        System.out.println("=========loginPass:" + login_pass + "======");
        Manager manager = managerDao.selectManager(login_name, login_pass);
        System.out.println("user1================================" + manager);

        //MD5 与所登录的密码是否一致，就是所登录的密码是否与数据库中的MD5一致
        if (manager != null) {
            return manager;
        } else {
            throw new Exception("用户名不存在或者密码错误!"); // 抛异常
        }
    }

    @Override
    public int addPro(String productName, String productPrice, String productTypeId,
                      String productDes, CommonsMultipartFile file, HttpSession session) {

        // 获取上传的文件名
        String originalFileName = file.getOriginalFilename();
        System.out.println("……………………………………………………上传的文件名:………………………………………………………………………………………………………………" + originalFileName);

        // 上传路径
        String uploadPath = session.getServletContext().getRealPath("/WEB-INF/upload/");

        //  保存到t_user表中的头像路径
        //  当天日期格式化：yyyyMMdd
        String time = new SimpleDateFormat("yyyyMMdd").format(new Date());
        String imgPath = time + File.separator + originalFileName;

        int i = productDao.addPro(productName, productPrice, productTypeId, productDes, imgPath);

        // 创建upload以及以年月日命名的文件夹
        File temp = new File(uploadPath, time);
        temp.mkdirs();

        // 上传文件
        try {
            file.transferTo(new File(uploadPath, imgPath));
        } catch (IOException e) {
            e.printStackTrace();
        }

        return i;

    }

    @Override
    public int updateProInfo(String proNo, String proName, String proPrice, int productTypeId) {
        int pNo = Integer.parseInt(proNo);
        Double pPrice = Double.valueOf(proPrice);
        System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%" + productTypeId);
        int i = productDao.updateProInfo(proName, pPrice, productTypeId,pNo);
        return i;
    }

    @Override
    public int addProductType(String productTypeName) {

        return productTypeDao.addProductType(productTypeName);
    }


    @Override
    public int updateProTypeInfo(String proTypeName, String typeId) {

        System.out.println("|||||||||||||||====proTypeName"+proTypeName+"|||||||typeId=|||"+typeId);
        Integer id = Integer.valueOf(typeId);
        int updateProTypeInfo = productTypeDao.updateProTypeInfo(proTypeName, id);
        return updateProTypeInfo;
    }

    @Override
    public String banProById(Integer banId) {
        int updateStatus = productDao.updateProStatus(banId);
        if (updateStatus != 0) {
            return "true";
        } else {
            return "false";
        }
    }

    @Override
    public String banProTypeById(Integer banId) {
        int updateStatus = productTypeDao.updateProTypeStatus(banId);
        if (updateStatus != 0) {
            return "true";
        } else {
            return "false";
        }
    }



}
