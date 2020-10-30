package com.amei.pojo;

import java.io.Serializable;
import java.util.Date;


public class User implements Serializable {
    private Integer id;
    private  String username;
    private String loginName;
    private String loginPass;
    private String phone;
    private String address;
    private String status;
    private String head;
    private String images;
    private Date registerDate;

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", loginName='" + loginName + '\'' +
                ", loginPass='" + loginPass + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", status='" + status + '\'' +
                ", head='" + head + '\'' +
                ", images='" + images + '\'' +
                ", registerDate=" + registerDate +
                '}';
    }
    public User() {

    }

    public User(Integer id, String username, String loginName, String loginPass, String phone, String address, String status, String head, String images, Date registerDate) {
        this.id = id;
        this.username = username;
        this.loginName = loginName;
        this.loginPass = loginPass;
        this.phone = phone;
        this.address = address;
        this.status = status;
        this.head = head;
        this.images = images;
        this.registerDate = registerDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getLoginPass() {
        return loginPass;
    }

    public void setLoginPass(String loginPass) {
        this.loginPass = loginPass;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getHead() {
        return head;
    }

    public void setHead(String head) {
        this.head = head;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }
}
