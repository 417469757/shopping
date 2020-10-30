package com.amei.service.impl;

import com.amei.dao.OrderDao;
import com.amei.pojo.Order;
import com.amei.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ItemServiceImpl implements ItemService {

    @Autowired
    private  OrderDao orderdao;

    @Override
    public Order findItemsByOrderNo(String orderNo) {
        Order  item =  orderdao.selectByOrderNo(orderNo);
        return item;
    }

    @Override
    public List<Order> findOrderAndItems(Integer userId) {
        List<Order>  item =  orderdao.findOrderAndItems(userId);
        return item;
    }
}
