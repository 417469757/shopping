package com.amei.service;

import com.amei.pojo.Ad;
import com.amei.pojo.AdVo;

import java.util.List;

public interface AdService {
    List<Ad> getAllAdsByTypeId(Integer typeId);

    List<AdVo> getAdInfo();
}
