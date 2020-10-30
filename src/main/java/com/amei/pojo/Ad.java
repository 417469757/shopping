package com.amei.pojo;

import lombok.Data;

import java.io.Serializable;

@Data
public class Ad implements Serializable {

    private Integer id;
    private Integer pId;
    private Integer pTypeId;
    private String adTitle;
    private String adImgUrl;
    private String adDetailUrl;

}
