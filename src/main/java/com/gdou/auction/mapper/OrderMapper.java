package com.gdou.auction.mapper;

import com.gdou.auction.pojo.Order;
import com.gdou.auction.pojo.OrderExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface OrderMapper {
    long countByExample(OrderExample example);

    int deleteByExample(OrderExample example);

    int deleteByPrimaryKey(Integer orderId);

    int insert(Order record);

    int insertSelective(Order record);

    List<Order> selectByExample(OrderExample example);

    List<Order> selectByExampleWithUserAndItem(Map<String,Object> map);

    Order selectByPrimaryKey(Integer orderId);

    Order selectByPrimaryKeyWithUserAndItem(Integer orderId);

    int updateByExampleSelective(@Param("record") Order record, @Param("example") OrderExample example);

    int updateByExample(@Param("record") Order record, @Param("example") OrderExample example);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);

    int confirm(Order order);

    int pay(Integer orderId);
}