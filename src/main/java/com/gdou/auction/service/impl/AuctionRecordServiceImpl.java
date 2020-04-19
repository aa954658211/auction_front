package com.gdou.auction.service.impl;

import com.gdou.auction.mapper.AuctionRecordMapper;
import com.gdou.auction.pojo.AuctionRecord;
import com.gdou.auction.service.AuctionRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author hua
 * @date 2020/4/18 - 9:29
 */
@Service
public class AuctionRecordServiceImpl implements AuctionRecordService {
    @Autowired
    private AuctionRecordMapper auctionRecordMapper;

    @Override
    public int updateStatus(Integer itemId) {
        return auctionRecordMapper.updateStatus(itemId);
    }

    @Override
    public AuctionRecord findPriceByItemId(Integer itemId) {
        return auctionRecordMapper.findPriceByItemId(itemId);
    }

    @Override
    public int save(AuctionRecord auctionRecord) {
        return auctionRecordMapper.insertSelective(auctionRecord);
    }
}
