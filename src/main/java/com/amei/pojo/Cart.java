package com.amei.pojo;

import com.amei.pojo.Product;
import com.amei.pojo.User;
import java.io.Serializable;

public class Cart implements Serializable {
    private  Integer  id;
    private  Integer  num;
    private  Product  product;
    private  User   user;
    private Boolean isChecked;

    public Boolean getChecked() {
        return isChecked;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "id=" + id +
                ", num=" + num +
                ", product=" + product +
                ", user=" + user +
                ", isChecked=" + isChecked +
                '}';
    }

    public void setChecked(Boolean checked) {
        isChecked = checked;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}
