package com.amei.pojo;

//import lombok.Data;

import java.io.Serializable;

//@Data
public class AdVo implements Serializable {

    private Integer id;
    private Integer pId;
    private Integer pTypeId;
    private String adTitle;
    private String adImgUrl;
    private String adDetailUrl;
    private ProductType productType;

    @Override
    public String toString() {
        return "AdVo{" +
                "id=" + id +
                ", pId=" + pId +
                ", pTypeId=" + pTypeId +
                ", adTitle='" + adTitle + '\'' +
                ", adImgUrl='" + adImgUrl + '\'' +
                ", adDetailUrl='" + adDetailUrl + '\'' +
                ", productType=" + productType +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getpId() {
        return pId;
    }

    public void setpId(Integer pId) {
        this.pId = pId;
    }

    public Integer getpTypeId() {
        return pTypeId;
    }

    public void setpTypeId(Integer pTypeId) {
        this.pTypeId = pTypeId;
    }

    public String getAdTitle() {
        return adTitle;
    }

    public void setAdTitle(String adTitle) {
        this.adTitle = adTitle;
    }

    public String getAdImgUrl() {
        return adImgUrl;
    }

    public void setAdImgUrl(String adImgUrl) {
        this.adImgUrl = adImgUrl;
    }

    public String getAdDetailUrl() {
        return adDetailUrl;
    }

    public void setAdDetailUrl(String adDetailUrl) {
        this.adDetailUrl = adDetailUrl;
    }

    public ProductType getProductType() {
        return productType;
    }

    public void setProductType(ProductType productType) {
        this.productType = productType;
    }
}
