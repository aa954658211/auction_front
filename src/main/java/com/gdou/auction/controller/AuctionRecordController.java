package com.gdou.auction.controller;

import com.gdou.auction.pojo.AuctionRecord;
import com.gdou.auction.pojo.Msg;
import com.gdou.auction.service.AuctionRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

/**
 * @author hua
 * @date 2020/4/18 - 9:30
 */
@Controller
@RequestMapping("/auctionRecord")
public class AuctionRecordController {
    @Autowired
    private AuctionRecordService auctionRecordService;

    @PostMapping("/save")
    @ResponseBody
    public Msg save(AuctionRecord auctionRecord){
        auctionRecord.setTime(new Date());
        //查询出价最高的人
        AuctionRecord high = auctionRecordService.findPriceByItemId(auctionRecord.getItemId());
        int i = 0;
        if (high == null){   //还没有人出价
            auctionRecord.setStatus("领先");
            //将其他所有的状态改为出局
            auctionRecordService.updateStatus(auctionRecord.getItemId());
        }else{
            //只能出价更高
            if (high.getPrice() >= auctionRecord.getPrice()){
                return Msg.fail().add("high",auctionRecord.getPrice());
            }else {
                auctionRecord.setStatus("领先");
                //将其他所有的状态改为出局
                auctionRecordService.updateStatus(auctionRecord.getItemId());
            }
        }
        i = auctionRecordService.save(auctionRecord);
        if (i>0){
            return Msg.success().add("high",auctionRecord.getPrice());
        }
        return Msg.fail().add("high",auctionRecord.getPrice());
    }
}
