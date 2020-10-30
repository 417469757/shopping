package com.amei.pojo;

import lombok.Data;

import java.io.Serializable;

@Data
public class ProductVo implements Serializable {


    private  Integer id;
    private  String pNo;
    private  String pName;
    private  Integer pTypeId;
    private  String pTypeName;
    private   Double pPrice;
    private  String pImg;
    private  String pDescription;
    private  Integer pStatus;
    private ProductType productType;


}
