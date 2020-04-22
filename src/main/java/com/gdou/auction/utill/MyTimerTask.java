package com.gdou.auction.utill;

import com.gdou.auction.pojo.AuctionRecord;
import com.gdou.auction.pojo.Item;
import com.gdou.auction.pojo.Order;
import com.gdou.auction.service.AuctionRecordService;
import com.gdou.auction.service.ItemService;
import com.gdou.auction.service.OrderService;

import java.util.Date;
import java.util.TimerTask;
import java.util.UUID;

/**
 * @author hua
 * @date 2020/4/20 - 10:05
 */
public class MyTimerTask extends TimerTask {

    private  AuctionRecordService auctionRecordService;
    private  ItemService itemService;
    private  OrderService orderService;
    //所属商品
    private Item item;

    public MyTimerTask(AuctionRecordService auctionRecordService, ItemService itemService, OrderService orderService, Item item) {
        this.auctionRecordService = auctionRecordService;
        this.itemService = itemService;
        this.orderService = orderService;
        this.item = item;
    }

    public MyTimerTask(){
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    @Override
    public void run() {
        System.out.println(this.getItem());
        //找出出价最高的出价纪录
        AuctionRecord priceByItemId = auctionRecordService.findPriceByItemId(this.getItem().getItemId());
        if (priceByItemId == null){
            //将商品状态改为流拍，即没有人出价
            Item record = new Item();
            record.setStatus(3);
            record.setUserId(this.getItem().getUserId());
            record.setItemId(this.getItem().getItemId());
            itemService.updateStatusByUserIdAndItemId(record);
            System.out.println(this.getItem().getItemId()+"将商品状态改为流拍，即没有人出价");
        }else{
            //生成一个订单
            Order order = new Order();
            order.setCreateTime(new Date());
            order.setItemId(priceByItemId.getItemId());
            order.setPrice(priceByItemId.getPrice());
            order.setOrderNo(UUID.randomUUID().toString());
            order.setStatus(0);
            order.setUserId(priceByItemId.getUserId());
            orderService.generate(order);
        }

    }
}
