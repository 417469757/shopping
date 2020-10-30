package com.amei.controller;

import com.amei.pojo.Cart;
import com.amei.pojo.Item;
import com.amei.pojo.Order;
import com.amei.pojo.User;
import com.amei.service.ItemService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Set;

@RequestMapping("/item")
@Controller
public class ItemsController {

    @Autowired
    ItemService itemService;

    @RequestMapping("/showItems")
    public String showItems(@Param("orderId") Integer orderId,Model model){

        model.addAttribute("navIndex", 1);// 购物车索引
        return "订单详情页面";
    }


    //某个订单详情
    @RequestMapping("/showItemDetails")
    public String showItemDetails(@RequestParam("orderNo") String orderNo, Model model, HttpSession httpSession) {
//        User user = (User) httpSession.getAttribute("user");
        Order allOrder = itemService.findItemsByOrderNo(orderNo);
        Set<Item> items = allOrder.getItems();
        model.addAttribute("items", items);
        model.addAttribute("navIndex",1);
        return "items";
    }


    //为安卓app提供数据
    @RequestMapping("/showAndroidItemDetails")
    @ResponseBody
    public List<Order> showAndroidItemDetails(@RequestParam("userId") Integer userId) {
        List<Order> allOrder = itemService.findOrderAndItems(userId);
        return allOrder;
    }
}
