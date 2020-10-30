package com.amei.controller;

import com.amei.pojo.Ad;
import com.amei.pojo.AdVo;
import com.amei.service.AdService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/ad")
public class AdController {

    @Autowired
    private AdService adService;

    @RequestMapping("/getAdsByType")
    @ResponseBody
    public List<Ad> getAdsByType(@RequestParam("typeId") Integer typeId){
        List<Ad> allAdsByTypeId = adService.getAllAdsByTypeId(typeId);
        return allAdsByTypeId;
    }

    //得到广告的所有信息，包括有：广告标题，和广告图片路径
    @RequestMapping("/getAdInfo")
    @ResponseBody
    public  List<AdVo> getAdInfo(){
        List<AdVo> allAdsByTypeId = adService.getAdInfo();
        return allAdsByTypeId;
    }


}
