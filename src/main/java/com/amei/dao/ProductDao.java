package com.amei.dao;

import com.amei.pojo.Product;
import com.amei.pojo.ProductVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductDao {
    List<Product> selectByParam(@Param("minPrice") Double minPrice,
                                       @Param("maxPrice") Double maxPrice,
                                       @Param("productTypeId") Integer productTypeId,
                                       @Param("pageNumKey") Integer pageNumKey,
                                       @Param("pageSizeKey") Integer pageSizeKey);

    int addPro(@Param("productName") String productName, @Param("productPrice") String productPrice,
               @Param("productTypeId") String productTypeId,@Param("productDes") String productDes,
               @Param("imgPath") String imgPath);

    List<ProductVo> selectAllPro();

    int updateProInfo(@Param("proName") String proName,
                      @Param("proPrice") Double proPrice,
                      @Param("proType") int proType,
                      @Param("proNo") int proNo);

    int selectIdByTypeName(String proTypeName);

    int updateProStatus(Integer banId);

    List<ProductVo> selectAllProByStatus(Integer productTypeStatusEnable);

    List<Product> selectProListByStatus(Integer productTypeStatusEnable);

    ProductVo selectOneProById(int parseInt);


//    int addProductType(String productTypeName);
}
