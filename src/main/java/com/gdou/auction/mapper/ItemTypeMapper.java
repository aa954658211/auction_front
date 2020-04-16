package com.gdou.auction.mapper;

import com.gdou.auction.pojo.ItemType;
import com.gdou.auction.pojo.ItemTypeExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ItemTypeMapper {
    long countByExample(ItemTypeExample example);

    int deleteByExample(ItemTypeExample example);

    int deleteByPrimaryKey(Integer itemTypeId);

    int insert(ItemType record);

    int insertSelective(ItemType record);

    List<ItemType> selectByExample(ItemTypeExample example);

    ItemType selectByPrimaryKey(Integer itemTypeId);

    int updateByExampleSelective(@Param("record") ItemType record, @Param("example") ItemTypeExample example);

    int updateByExample(@Param("record") ItemType record, @Param("example") ItemTypeExample example);

    int updateByPrimaryKeySelective(ItemType record);

    int updateByPrimaryKey(ItemType record);
}