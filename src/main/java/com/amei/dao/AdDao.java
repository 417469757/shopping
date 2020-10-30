package com.amei.dao;

import com.amei.pojo.Ad;
import com.amei.pojo.AdVo;

import java.util.List;

public interface AdDao {
    List<Ad> getAllAdsByTypeId(Integer typeId);

    List<AdVo> getAdInfo();
}
