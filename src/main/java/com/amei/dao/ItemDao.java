package com.amei.dao;

import com.amei.pojo.Item;
import org.apache.ibatis.annotations.Param;

public interface ItemDao {
    void insert(@Param("item") Item item);
    Item findItemsByOrderId(String orderNo);
}
