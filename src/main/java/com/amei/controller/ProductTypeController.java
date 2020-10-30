package com.amei.controller;

import com.amei.constant.StatusConstant;
import com.amei.pojo.ProductType;
import com.amei.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/type")
public class ProductTypeController {

    @Autowired
    ProductTypeService productTypeService;

    @RequestMapping("/getAllTypes")
    @ResponseBody
    public List<ProductType> getAllTypes(){

        List<ProductType> allTypesByStatus = productTypeService.getAllTypesByStatus(StatusConstant.PRODUCT_TYPE_STATUS_ENABLE);
        return allTypesByStatus;
    }



}
