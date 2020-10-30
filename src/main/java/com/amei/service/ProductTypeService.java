package com.amei.service;

import com.amei.pojo.Product;
import com.amei.pojo.ProductType;

import java.util.List;

public interface ProductTypeService{


    List<ProductType> getAllTypesByStatus(Integer status);

    List<ProductType> getAllTypes();
}
