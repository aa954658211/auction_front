package com.gdou.auction.service;

import com.gdou.auction.pojo.AuctionRecord;

import java.util.List;

/**
 * @author hua
 * @date 2020/4/18 - 9:28
 */
public interface AuctionRecordService {
    int save(AuctionRecord auctionRecord);

    AuctionRecord findPriceByItemId(Integer itemId);

    int updateStatus(Integer itemId);

    List<AuctionRecord> findListByItemId(Integer itemId);

    AuctionRecord findByUserIdAndItemId(Integer userId,Integer itemId);

    int updatePriceById(AuctionRecord auctionRecord);
}
