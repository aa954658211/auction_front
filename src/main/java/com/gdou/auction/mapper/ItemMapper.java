package com.gdou.auction.mapper;

import com.gdou.auction.pojo.Item;
import com.gdou.auction.pojo.ItemExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ItemMapper {
    long countByExample(ItemExample example);

    int deleteByExample(ItemExample example);

    int deleteByPrimaryKey(Integer itemId);

    int insert(Item record);

    int insertSelective(Item record);

    List<Item> selectByExample(ItemExample example);

    List<Item> selectByExampleWithItemType(ItemExample example);

    Item selectByPrimaryKey(Integer itemId);

    Item selectByPrimaryKeyWithItemType(Integer itemId);

    int updateByExampleSelective(@Param("record") Item record, @Param("example") ItemExample example);

    int updateByExample(@Param("record") Item record, @Param("example") ItemExample example);

    int updateByPrimaryKeySelective(Item record);

    int updateByPrimaryKey(Item record);
}