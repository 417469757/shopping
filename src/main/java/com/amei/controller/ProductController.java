package com.amei.controller;

import com.amei.constant.StatusConstant;
import com.amei.pojo.Product;
import com.amei.pojo.ProductType;
import com.amei.pojo.ProductVo;
import com.amei.service.ProductSerivce;
import com.amei.service.ProductTypeService;
import com.github.pagehelper.PageInfo;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.List;


@Controller
public class ProductController {

    private  Logger logger = Logger.getLogger(ProductController.class);

    @Autowired
    private ProductTypeService productTypeService;

    @Autowired
    private ProductSerivce productService;


    @RequestMapping("/showMain")
    public String showMain(Model model){
        List<Product> productList = productService.finProductByParam(null, null,
                null, StatusConstant.DEFAULT_PAGE_NO, StatusConstant.PAGE_SIZE);
        PageInfo<Product> productPageInfo = new PageInfo<>(productList);
        logger.debug("商品信息-------------》"+productPageInfo);
        model.addAttribute("productPageInfo",productPageInfo);
        model.addAttribute("navIndex", 0);
        return "main";
    }


    @RequestMapping("/getAllProducts")
    @ResponseBody
    public List<Product> getProductList(@RequestParam("typeId") Integer typeId){
        List<Product> proList = productService.finProductByParam(null,null,typeId,null,null);
        return proList;
    }

    /**
     * 商品图片下载 (通用方式)
     * @param imgUrl
     */
    @RequestMapping("/downloadImg")
    public  void   downloadImg(@RequestParam("imgUrl") String imgUrl, HttpSession session,
                               HttpServletResponse response){
        logger.debug("参数：imgUrl-----------"+imgUrl);
        //  获得图片所在路径
        String uploadPath =session.getServletContext().getRealPath("/WEB-INF/upload/");
        // 图片完整路径
        String  imgName = uploadPath + File.separator + imgUrl;
        FileInputStream in = null;
        OutputStream out = null;
        try {
            in =  new FileInputStream(imgName);
            out = response.getOutputStream();
            response.setContentType("image/jpeg");    // 必须设置响应数据的解析方式
            byte[] b = new byte[2048];
            int len = 0;
            while( (len = in.read(b)) !=-1){    // 当读到的长度为-1时，结束
                out.write(b,0,len);      // 读取多少长度就写入多少长度
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            try {
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
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
        logger.debug("商品类型:--------------"+typeList);
        return  typeList;
    }

    @RequestMapping("/findProductByParam")
    public String  findProductByParam(@RequestParam("minPrice") Double minPrice,
                                      @RequestParam("maxPrice") Double maxPrice,
                                      @RequestParam("productTypeId") Integer productTypeId,
                                      Integer pageNo, Model model
    ){

        logger.debug("pageNo---------------"+pageNo);
        // 处理一下参数
        if(pageNo == null ){
            pageNo = 1;
        }
        // 根据条件查询到的的商品信息
        List<Product> productList =   productService.finProductByParam(minPrice, maxPrice, productTypeId,
                pageNo, StatusConstant.PAGE_SIZE);

        PageInfo<Product> productPageInfo =  new PageInfo<>(productList);

        logger.debug("商品信息-----------:"+productPageInfo);

        // 模型
        model.addAttribute("productPageInfo", productPageInfo);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("productTypeId", productTypeId);

        return "main";
    }

}


