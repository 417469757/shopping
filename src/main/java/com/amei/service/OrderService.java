package com.amei.service;

import com.amei.pojo.Cart;
import com.amei.pojo.Item;
import com.amei.pojo.Order;
import com.amei.pojo.User;

import java.util.List;

public interface OrderService {
    String creatOrder(List<Cart> carList, User user);
    List<Order> findOrdersByUserId(Integer userId);

    Item findItemsByOrderId(String orderId);
}
