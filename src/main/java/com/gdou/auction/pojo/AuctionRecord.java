package com.gdou.auction.pojo;

import java.util.Date;

public class AuctionRecord {
    private Integer id;

    private Integer itemId;

    private Integer userId;

    private Integer price;

    private Date time;

    private String status;

    private User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "AuctionRecord{" +
                "id=" + id +
                ", itemId=" + itemId +
                ", userId=" + userId +
                ", price=" + price +
                ", time=" + time +
                ", status='" + status + '\'' +
                '}';
    }
}