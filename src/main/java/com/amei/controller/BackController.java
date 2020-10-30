package com.amei.controller;

import com.amei.constant.StatusConstant;
import com.amei.pojo.*;
import com.amei.service.BackService;
import com.amei.service.ProductSerivce;
import com.amei.service.ProductTypeService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/back")
public class BackController {

    @Autowired
    private BackService backService;

    @Autowired
    private ProductSerivce productSerivce;

    @Autowired
    private ProductTypeService productTypeService;

    //管理员登录
    @RequestMapping("/showLogin")
    public String showLogin() {
        return "back/login";
    }

    //管理员退出登录
    @RequestMapping("/loginOut")
    public String loginOut(HttpSession session) {

        session.removeAttribute("manager");
        //  return "main";
        return "redirect:/showMain";
    }

    //展示管理页面
    @RequestMapping("/showMain")
    public String showMain() {
        return "back/main";
    }

    //展示所有商品根据商品的状态
    @RequestMapping("/showProductManager")
    public String showProduct(Model model) {

        List<ProductVo> productList = productSerivce.selectAllProByStatus();
        System.out.println("(((((((((((((((((((((((((((((((("+productList);
        model.addAttribute("productList",productList);
        return "back/productManager";
    }

    //展示所有商品类型根据商品类型的状态
    @RequestMapping("/showProductTypeManager")
    public String showProductType(Model model) {

        List<ProductType> allTypes = productTypeService.getAllTypesByStatus(StatusConstant.PRODUCT_TYPE_STATUS_ENABLE);
        model.addAttribute("productTypeList" ,allTypes);

        return "back/productTypeManager";
    }

    //客户端登录
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@RequestParam("login_name") String login_name,
                        @RequestParam("login_pass") String login_pass,
                        HttpSession session,Model model)  {

        try {
            Manager manager = backService.login(login_name, login_pass);
            session.setAttribute("manager", manager.getLoginName());
            model.addAttribute("manager",manager.getLoginName());
            System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@"+manager.getLoginName());
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 转发到请求
        return "redirect:showMain";
    }

    //添加商品
    @RequestMapping("/addProduct")
    public String addProduct(@RequestParam("productName") String productName,
                             @RequestParam("productPrice") String productPrice,
                             @RequestParam("productTypeId") String productTypeId,
                             @RequestParam("productDes") String productDes,
                             @RequestParam("pImg") CommonsMultipartFile file,
                             HttpSession session,
                             Model model) throws Exception {

        System.out.println("===================file=$$$$$$$$$$$"+file);

        List<ProductType> allTypesByStatus = productTypeService.getAllTypesByStatus(StatusConstant.PRODUCT_TYPE_STATUS_ENABLE);
        model.addAttribute("typeIds",allTypesByStatus);

        List<ProductVo> productList = productSerivce.selectAllPro();
        model.addAttribute("productList",productList);

        int addPro = backService.addPro(productName, productPrice,productTypeId,productDes,file,session);


        if (addPro>=0){
            return "redirect:showProductManager";
        }else {
            throw new Exception("添加商品失败");
        }
    }



    /**
     *  @ModelAttribute  注解放在方法上方，表示每次请求都会执行getTypes方法
     *                                    将查出的数据放到request作用域中
     * @return
     */
    @ModelAttribute("typeList")
    public List<ProductType>  getTypes(){
        List<ProductType>  typeList =  productTypeService.getAllTypesByStatus(StatusConstant.PRODUCT_TYPE_STATUS_ENABLE);
        return  typeList;
    }




    //添加商品类型
    @RequestMapping("/addProductType")
    public String addProductType(@RequestParam("productTypeName") String productTypeName) throws Exception {

        int addProType = backService.addProductType(productTypeName);
        if (addProType>0){
            return "redirect:showProductTypeManager";
        }else {
            throw new Exception("添加商品类型失败");
        }

    }

    //后台修改产品信息做回显
    @PostMapping("/beforeUpdateProInfo")
    @ResponseBody
    public ProductVo beforeUpdateProInfo(String id){

        Integer i = Integer.valueOf(id);
        System.out.println("===========回显用的id、："+i);
        ProductVo productVo = productSerivce.selectOneProById(i);
        System.out.println("------------"+productVo);

        return productVo;

    }

    //后台修改产品信息
    @RequestMapping("/updateInfo")
    public String afterUpdateProInfo(@RequestParam("proName") String proName,
                              @RequestParam("proPrice") String proPrice,
                              @RequestParam("productTypeId") String proTypeId,
                              @RequestParam("proNo") String proNo) throws Exception {
        System.out.println("!!!!proName!!!!"+proName+"!!!!!proPrice"+proPrice+"!!!!proTypeId"+proTypeId+"!!!!proNo"+proNo);

        int pTypeId = Integer.parseInt(proTypeId);
        int i = backService.updateProInfo(proNo, proName,proPrice,pTypeId);
        if (i>0){
            return "redirect:showProductManager";
        }else {
            throw new Exception("添加商品失败");
        }

    }

    //更改商品类型
    @RequestMapping("/updateProTypeInfo")
    @ResponseBody
    public String updateProTypeInfo( String proTypeName, String typeId) throws Exception {
        System.out.println("==proTypeName==="+proTypeName+"#####typeId####"+typeId);
        int addProType = backService.updateProTypeInfo(proTypeName,typeId);
        if (addProType>0){
            return "true";
        }else {
            throw new Exception("更改商品类型失败");
        }
    }

   //禁用某个商品
    @RequestMapping(value = "/BanPro", method = RequestMethod.POST)
    public String banPro(@RequestParam("banId") Integer banId) {

        System.out.println("===============================" + banId);
        String result = backService.banProById(banId);
        return result;
    }

    //禁用某个商品类型
    @RequestMapping(value = "/BanProType", method = RequestMethod.POST)
    public String banProType(@RequestParam("banTypeId") Integer banId) {

        System.out.println("===============================" + banId);
        String result = backService.banProTypeById(banId);
        return result;
    }



}
