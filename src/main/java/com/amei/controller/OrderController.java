package com.amei.controller;

import com.amei.pojo.Cart;
import com.amei.pojo.Order;
import com.amei.pojo.User;
import com.amei.service.CartService;
import com.amei.service.ItemService;
import com.amei.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {
    /**
     * 跳转到center.jsp
     *
     * @return
     */


    @Autowired
    public CartService cartService;

    @Autowired
    public OrderService orderService;

    @Autowired
    public ItemService itemService;

    @RequestMapping("/showOrder")
    public String showOrder(Model model,HttpSession session) {

        model.addAttribute("navIndex", 1);// 购物车索引

        User user = (User) session.getAttribute("user");
        Integer userId = user.getId();
        List<Order> orderList = orderService.findOrdersByUserId(userId);
        System.out.println("==========orderList==============="+orderList+"=====================");
        session.setAttribute("orderList", orderList);
//        orderService.findItemsByOrderId(orderId);
        return "order";
    }

    //某个订单详情   localhost:8080/shoping/order/showItemDetails?orderNo=6fb5150b-cbee-49e9-8228-9f5a63982466
    @RequestMapping("/showItemDetails")
    @ResponseBody
    public Order showItemDetails(Model model, HttpSession httpSession,String orderNo) {
//        User user = (User) httpSession.getAttribute("user");
        Order allOrder = itemService.findItemsByOrderNo(orderNo);
        model.addAttribute("item", allOrder);// 购物车索引
        return allOrder;
    }


    @RequestMapping("/showAccount")
    public String showAccount(@RequestParam("carIds") String carIds, Model model,
                              HttpSession session) {
        User user = (User) session.getAttribute("user");
        // 将字符串转为集合list
        String[] ids = carIds.split(","); // 以逗号分割字符串，放到数组中
        List<String> carIdList = Arrays.asList(ids); // 数组转为集合

        // 调用Service层获取要购买的商品
        List<Cart> carList = cartService.findByUserIdAndCarIds(user.getId(), carIdList);
        System.out.println("=====$$$$$$$$$showAccount$$$$$$$========carList"+carList);
        model.addAttribute("#¥¥¥¥¥showAccount¥¥carList", carList);
        session.setAttribute("carList", carList);
        model.addAttribute("navIndex", 2);// 购物车索引
        return "myOrders";
    }


    @RequestMapping("/deleteCart")
    public String deleteCart(@RequestParam("carIds") String carIds, Model model,
                             HttpSession session) {

        User user = (User) session.getAttribute("user");
        // 将字符串转为集合list
        String[] ids = carIds.split(","); // 以逗号分割字符串，放到数组中
        List<String> carIdList = Arrays.asList(ids); // 数组转为集合
        // 调用Service层获取要购买的商品

        String result = cartService.deleteCart(user.getId(), carIdList);
        model.addAttribute("navIndex", 2);// 购物车索引
        return result;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public String createOrder(HttpSession session) {

        List<Cart> carList = (List<Cart>) session.getAttribute("carList");

        User user = (User) session.getAttribute("user");
        System.out.println("=============" + carList + "===========");
        System.out.println("=============" + user + "===========");
        String s = orderService.creatOrder(carList, user);// 将订单编号返回
        return s;
    }




}
