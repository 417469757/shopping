package com.amei.service.impl;

import com.amei.dao.AdDao;
import com.amei.pojo.Ad;
import com.amei.pojo.AdVo;
import com.amei.service.AdService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class AdServiceImpl implements AdService {

    @Autowired
    AdDao adDao;

    @Override
    public List<Ad> getAllAdsByTypeId(Integer typeId) {
        List<Ad> allAdsByTypeId = adDao.getAllAdsByTypeId(typeId);
        return allAdsByTypeId;
    }

    @Override
    public List<AdVo> getAdInfo() {
        List<AdVo> adInfoList = adDao.getAdInfo();
        return adInfoList;
    }
}
