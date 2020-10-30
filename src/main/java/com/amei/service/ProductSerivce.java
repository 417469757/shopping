package com.amei.service;

import com.amei.pojo.Product;
import com.amei.pojo.ProductVo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface ProductSerivce {

    List<Product> finProductByParam(Double minPrice, Double maxPrice, Integer productTypeId, Integer pageNo, Integer pageSize);

    List<ProductVo> selectAllPro();
    List<ProductVo> selectAllProByStatus();

    List<Product> selectProList();

    ProductVo selectOneProById(int parseInt);
}
