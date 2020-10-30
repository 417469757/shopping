package com.amei.service.impl;


import com.amei.dao.CartDao;
import com.amei.dao.ItemDao;
import com.amei.dao.OrderDao;
import com.amei.pojo.Cart;
import com.amei.pojo.Item;
import com.amei.pojo.Order;
import com.amei.pojo.User;
import com.amei.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderDao orderDao;

    @Autowired
    private ItemDao itemDao;

    @Autowired
    private CartDao cartDao;

    @Override
    public String creatOrder(List<Cart> carList, User user) {

        // 1.先往t_order表里面新增订单记录,自动生成订单id
        Order order = new Order();
        String no = UUID.randomUUID().toString(); // 订单编号
        System.out.println("======*************========"+no+"=======*************=========");
        order.setNo(no);
        order.setUser(user);
        orderDao.insert(order);
        // 2.往t_item表中插入商品信息（需要用到上一步拿到的id）
        // 3.将购物车中对应商品记录删除
        for (int i = 0; i < carList.size(); i++) {
            Item item = new Item();
            item.setOrder(order);
            item.setNum(carList.get(i).getNum());
            item.setProduct(carList.get(i).getProduct());
            itemDao.insert(item);

            cartDao.deleteById(carList.get(i).getId()); // 删除购物车中记录
        }
        return no;
    }

    //查找订单
    @Override
    public List<Order> findOrdersByUserId(Integer userId) {
        return orderDao.selectByUserId(userId);
    }

    //查找订单详情
    @Override
    public Item findItemsByOrderId(String orderNo) {
        Item itemsByOrderId = itemDao.findItemsByOrderId(orderNo);
        return itemsByOrderId;
    }
}
