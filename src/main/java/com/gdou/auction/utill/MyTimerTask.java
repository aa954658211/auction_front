package com.gdou.auction.utill;

import com.gdou.auction.pojo.Address;
import com.gdou.auction.pojo.AuctionRecord;
import com.gdou.auction.pojo.Item;
import com.gdou.auction.pojo.Order;
import com.gdou.auction.service.AddressService;
import com.gdou.auction.service.AuctionRecordService;
import com.gdou.auction.service.ItemService;
import com.gdou.auction.service.OrderService;

import java.util.Date;
import java.util.TimerTask;
import java.util.UUID;

/**
 * @author hua
 * @date 2020/4/23 - 17:53
 */
public class MyTimerTask extends TimerTask {

    private AuctionRecordService auctionRecordService;
    private ItemService itemService;
    private OrderService orderService;
    private AddressService addressService;
    //所属商品
    private Item item;

    public MyTimerTask(AuctionRecordService auctionRecordService, ItemService itemService, OrderService orderService,AddressService addressService,Item item) {
        this.auctionRecordService = auctionRecordService;
        this.itemService = itemService;
        this.orderService = orderService;
        this.addressService = addressService;
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
        //找出出价最高的出价纪录
        AuctionRecord priceByItemId = auctionRecordService.findPriceByItemId(this.getItem().getItemId());
        if (priceByItemId == null){
            //将商品状态改为流拍，即没有人出价
            Item record = new Item();
            record.setStatus(3);
            record.setUserId(this.getItem().getUserId());
            record.setItemId(this.getItem().getItemId());
            itemService.updateStatusByUserIdAndItemId(record);
        }else{
            //按照默认地址，生成一个订单,如果没有就不生成
            Order order = new Order();
            Address address = addressService.findDefaultByUserId(priceByItemId.getUserId());
            if (address!=null){
                order.setAddressId(address.getAddressId());
            }
            order.setUpdateTime(new Date());
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
