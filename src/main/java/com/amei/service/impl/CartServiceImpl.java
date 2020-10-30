package com.amei.service.impl;

import com.amei.dao.CartDao;
import com.amei.pojo.Cart;
import com.amei.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CartServiceImpl implements CartService {

    @Autowired
    private CartDao cartDao;


    @Override
    public String addCart(String productId, String userId) {
        int user_id = Integer.parseInt(userId);
        //查询购物车内产品是否存在
        Cart exitPro = cartDao.IsExitPro(productId,user_id);
        try {
            if (exitPro != null){//购物车有该产品
                cartDao.updateProNum(productId);
            }else {//购物车没有该产品
                cartDao.addCart(productId, userId);
            }
            return "true";
        }catch (Exception e){
            e.printStackTrace();
            return "false";
        }
    }

    @Override
    public List<Cart> findAllProByUserId(Integer userId) {
        List<Cart> allPro = cartDao.findAllProByUserId(userId);
        return allPro;
    }

    @Override
    public String  deleteById(Integer carId) {
        int i = cartDao.deleteById(carId);
        if (i!=0){
            return "true";
        }else {
            return "false";
        }
    }

    @Override
    public String updateNumById(Integer carId,Integer num) {
        int i = cartDao.updateNumById(carId, num);
        if (i!=0){
            return "true";
        }else {
            return "false";
        }
    }

    @Override
    public String deleteAllByIds(List<String> carIdList) {
        int i = cartDao.deleteByIds(carIdList);
        if (i!=0){
            return "true";
        }else {
            return "false";
        }
    }

    @Override
    public List<Cart> findByUserIdAndCarIds(Integer id, List<String> carIdList) {

        List<Cart> carts = cartDao.selectByUserIdAndCarIds(id, carIdList);

        return carts;

    }



    @Override
    public String deleteCart(Integer id, List<String> carIdList) {
        int i = cartDao.deleteCartByUserId(id, carIdList);
        if (i!=0){
            return "true";
        }else {
            return "false";
        }
    }

    @Override
    public List<Cart> getFrontAllCartProducts(Integer userId) {
        return cartDao.findAllProByUserId(userId);
    }


}
