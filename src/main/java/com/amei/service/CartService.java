package com.amei.service;


import com.amei.pojo.Cart;

import java.util.List;

public interface CartService {
    String addCart(String productId,String userId) ;

    List<Cart> findAllProByUserId(Integer userId);


    String deleteById(Integer carId);

    String  updateNumById(Integer carId,Integer num);

    String deleteAllByIds(List<String> carIdList);

    List<Cart> findByUserIdAndCarIds(Integer id, List<String> carIdList);


    String deleteCart(Integer id, List<String> carIdList);

    List<Cart> getFrontAllCartProducts(Integer userId);
}
