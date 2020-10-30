package com.amei.service.impl;

import com.amei.dao.ProductTypeDao;
import com.amei.pojo.ProductType;
import com.amei.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductTypeServiceImpl  implements ProductTypeService {

    @Autowired
    private  ProductTypeDao productTypeDao;


    @Override
    public List<ProductType> getAllTypesByStatus(Integer status) {
        return productTypeDao.getAllTypesByStatus(status);

    }

    @Override
    public List<ProductType> getAllTypes() {

       return productTypeDao.getAllTypes();
    }

}
