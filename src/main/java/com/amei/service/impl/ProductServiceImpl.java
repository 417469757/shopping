package com.amei.service.impl;

import com.amei.constant.StatusConstant;
import com.amei.dao.ProductDao;
import com.amei.pojo.Product;
import com.amei.pojo.ProductVo;
import com.amei.service.ProductSerivce;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductSerivce {

    @Autowired
    private ProductDao productDao;

    @Override
    public List<Product> finProductByParam(Double minPrice, Double maxPrice,
                                           Integer productTypeId, Integer pageNo,
                                           Integer pageSize) {

        List<Product>  productList =  productDao.selectByParam(minPrice, maxPrice, productTypeId, pageNo, pageSize);
        return productList;
    }

    @Override
    public List<ProductVo> selectAllPro() {
        List<ProductVo> productList = productDao.selectAllPro();
        return productList;
    }

    @Override
    public List<ProductVo> selectAllProByStatus() {
        List<ProductVo> productList = productDao.selectAllProByStatus(StatusConstant.PRODUCT_TYPE_STATUS_ENABLE);
        return productList;
    }

    @Override
    public List<Product> selectProList() {
        List<Product> productList = productDao.selectProListByStatus(StatusConstant.PRODUCT_TYPE_STATUS_ENABLE);
        return productList;
    }

    @Override
    public ProductVo selectOneProById(int parseInt) {
        ProductVo pro = productDao.selectOneProById(parseInt);
        return pro;
    }


}

