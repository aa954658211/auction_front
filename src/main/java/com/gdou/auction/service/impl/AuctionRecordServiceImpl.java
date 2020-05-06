package com.gdou.auction.service.impl;

import com.gdou.auction.mapper.AuctionRecordMapper;
import com.gdou.auction.pojo.AuctionRecord;
import com.gdou.auction.pojo.AuctionRecordExample;
import com.gdou.auction.service.AuctionRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
    public List<AuctionRecord> findListByItemId(Integer itemId) {
        AuctionRecordExample example = new AuctionRecordExample();
        example.createCriteria().andItemIdEqualTo(itemId);
        example.setOrderByClause("price desc");
        return auctionRecordMapper.selectByExampleWithUser(example);
    }

    @Override
    public AuctionRecord findByUserIdAndItemId(Integer userId,Integer itemId) {
        AuctionRecordExample example = new AuctionRecordExample();
        example.createCriteria().andUserIdEqualTo(userId).andItemIdEqualTo(itemId);
        List<AuctionRecord> list = auctionRecordMapper.selectByExample(example);
        if (list.isEmpty()){
            return null;
        }
        return list.get(0);
    }

    @Override
    public int updatePriceById(AuctionRecord auctionRecord) {
        return auctionRecordMapper.updateByPrimaryKeySelective(auctionRecord);
    }

    @Override
    public int save(AuctionRecord auctionRecord) {
        return auctionRecordMapper.insertSelective(auctionRecord);
    }
}
