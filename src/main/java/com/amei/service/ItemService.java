package com.amei.service;

import com.amei.pojo.Order;

import java.util.List;

public interface ItemService {

    Order findItemsByOrderNo(String orderNo);

    List<Order> findOrderAndItems(Integer userId);
}
