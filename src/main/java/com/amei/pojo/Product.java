package com.amei.pojo;

import lombok.Data;

@Data
public class Product {
    private  Integer id;
    private  String pNo;
    private  String pName;
    private  Integer pTypeId;
    private   Double pPrice;
    private  String pImg;
    private  String pDescription;
    private  String pStatus;

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", pNo='" + pNo + '\'' +
                ", pName='" + pName + '\'' +
                ", pTypeId=" + pTypeId +
                ", pPrice=" + pPrice +
                ", pImg='" + pImg + '\'' +
                ", pDescription='" + pDescription + '\'' +
                ", productType=" + productType +
                '}';
    }

    public String getpDescription() {
        return pDescription;
    }

    public void setpDescription(String pDescription) {
        this.pDescription = pDescription;
    }

    private  ProductType productType; // 多对一关系

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getpNo() {
        return pNo;
    }

    public void setpNo(String pNo) {
        this.pNo = pNo;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public Integer getpTypeId() {
        return pTypeId;
    }

    public void setpTypeId(Integer pTypeId) {
        this.pTypeId = pTypeId;
    }

    public Double getpPrice() {
        return pPrice;
    }

    public void setpPrice(Double pPrice) {
        this.pPrice = pPrice;
    }

    public String getpImg() {
        return pImg;
    }

    public void setpImg(String pImg) {
        this.pImg = pImg;
    }

    public ProductType getProductType() {
        return productType;
    }

    public void setProductType(ProductType productType) {
        this.productType = productType;
    }

}
