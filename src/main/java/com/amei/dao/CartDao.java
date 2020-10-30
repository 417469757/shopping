package com.amei.dao;

import com.amei.pojo.Cart;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CartDao {

    Cart IsExitPro(@Param("productId") String productId,@Param("userId") Integer userId);

    void updateProNum(String productId);

    void addCart(@Param("productId") String productId, @Param("userId") String userId);

    List<Cart> findAllProByUserId(Integer userId);

    int deleteById(Integer carId);

    int updateNumById(@Param("carId") Integer carId, @Param("num") Integer num);

    int deleteByIds(@Param("carIdList") List<String> carIdList);

    List<Cart> selectByUserIdAndCarIds(@Param("userId") Integer userId, @Param("ids") List<String> ids);

    int deleteCartByUserId(@Param("userId") Integer userId, @Param("carIdList") List<String> carIdList);

}
