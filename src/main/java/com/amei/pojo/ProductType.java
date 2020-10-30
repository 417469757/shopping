package com.amei.pojo;

import java.io.Serializable;

public class ProductType implements Serializable {

    private   Integer id;
    private   String typeName;
    private   Integer  status;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "ProductType{" +
                "id=" + id +
                ", typeName='" + typeName + '\'' +
                ", status=" + status +
                '}';
    }
}
