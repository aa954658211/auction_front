package com.gdou.auction.mapper;

import com.gdou.auction.pojo.AuctionRecord;
import com.gdou.auction.pojo.AuctionRecordExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AuctionRecordMapper {
    long countByExample(AuctionRecordExample example);

    int deleteByExample(AuctionRecordExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(AuctionRecord record);

    int insertSelective(AuctionRecord record);

    List<AuctionRecord> selectByExample(AuctionRecordExample example);

    AuctionRecord selectByPrimaryKey(Integer id);
    List<AuctionRecord> selectByExampleWithUser(AuctionRecordExample example);

    int updateByExampleSelective(@Param("record") AuctionRecord record, @Param("example") AuctionRecordExample example);

    int updateByExample(@Param("record") AuctionRecord record, @Param("example") AuctionRecordExample example);

    int updateByPrimaryKeySelective(AuctionRecord record);

    int updateByPrimaryKey(AuctionRecord record);

    AuctionRecord findPriceByItemId(Integer itemId);

    int updateStatus(Integer itemId);
}