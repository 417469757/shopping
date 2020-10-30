package com.amei.dao;

import com.amei.pojo.Order;

import java.util.List;

public interface OrderDao {

    void insert(Order order);

    List<Order> selectByUserId(Integer userId);


    Order selectByOrderNo(String orderNo);

    List<Order> findOrderAndItems(Integer userId);
}
