package com.amei.controller;

import com.amei.pojo.Cart;
import com.amei.pojo.User;
import com.amei.service.CartService;
import org.apache.log4j.Logger;
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
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    private Logger logger = Logger.getLogger(CartController.class);

    /**
     * 跳转到car.jsp
     *
     * @return
     */
    @RequestMapping("/showCart")
    public String showCart(Model model, HttpSession httpSession) {

        User user = (User) httpSession.getAttribute("user");
        model.addAttribute("navIndex", 2);// 购物车索引
        List<Cart> allPro = cartService.findAllProByUserId(user.getId());
        model.addAttribute("cartList", allPro);// 购物车索引
        return "cart";
    }


    @RequestMapping("/addCart")
    @ResponseBody
    public String addCart(@RequestParam("productId") String productId,
                          @RequestParam("userId") String userId,
                          Model model) {

        logger.debug("productId=======================" + productId);
        logger.debug("userId=======================" + userId);
        String addCart = cartService.addCart(productId, userId);
        return addCart;
    }

    @RequestMapping(value = "/deleteById", method = RequestMethod.POST)
    @ResponseBody
    public String deleteById(Integer carId) {

        System.out.println("===============================" + carId);
        String result = cartService.deleteById(carId);
        return result;
    }



    @RequestMapping(value = "/deleteAll",method = RequestMethod.POST)
    @ResponseBody
    public  String  deleteAll(@RequestParam("carIds") String carIds){
        // 将字符串转为集合list
        String[]  ids =  carIds.split(","); // 以逗号分割字符串，放到数组中
        System.out.println("=====================deleteAll========================="+ids);
        List<String> carIdList =  Arrays.asList(ids); // 数组转为集合
        String result = cartService.deleteAllByIds(carIdList);
        return result;
    }


    @RequestMapping(value = "/updateNumById", method = RequestMethod.POST)
    @ResponseBody
    public String updateNumById(Integer carId, Integer num) {
        System.out.println("==============" + carId + "============" + num);
        String result = cartService.updateNumById(carId, num);
        return result;
    }


    //为安卓app提供数据
    @RequestMapping("/getAllCartProducts")
    @ResponseBody
    public List<Cart> getAllCartProducts(@RequestParam("userId") Integer userId){

        List<Cart> cartVoList = cartService.getFrontAllCartProducts(userId);
        return cartVoList;

    }

}
