package com.gdou.auction.service;

import com.gdou.auction.pojo.AuctionRecord;

/**
 * @author hua
 * @date 2020/4/18 - 9:28
 */
public interface AuctionRecordService {
    int save(AuctionRecord auctionRecord);

    AuctionRecord findPriceByItemId(Integer itemId);

    int updateStatus(Integer itemId);
}
