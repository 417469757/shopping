package com.amei.dao;

import com.amei.pojo.ProductType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductTypeDao {
     List<ProductType> getAllTypesByStatus(Integer status);

    List<ProductType> getAllTypes();

    int addProductType(String productTypeName);

    int updateProTypeStatus(Integer banId);

    int updateProTypeInfo(@Param("proTypeName") String proTypeName,@Param("typeId") Integer typeId);

//    ProductType getIdByTypeName(String proTypeName);
}
