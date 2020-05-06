package com.gdou.auction.service.impl;

import com.gdou.auction.mapper.OrderMapper;
import com.gdou.auction.pojo.Order;
import com.gdou.auction.pojo.OrderExample;
import com.gdou.auction.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author hua
 * @date 2020/4/23 - 17:51
 */
@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderMapper orderMapper;

    @Override
    public Order get(Integer orderId) {
        return orderMapper.selectByPrimaryKeyWithUserAndItem(orderId);
    }

    @Override
    public List<Order> findListByUserIdAndStatus(Map<String,Object> map) {
        return orderMapper.selectByExampleWithUserAndItem(map);
    }

    @Override
    public int confirm(Order order) {
        return orderMapper.confirm(order);
    }

    @Override
    public long count(OrderExample orderExample) {
        return orderMapper.countByExample(orderExample);
    }

    @Override
    public int generate(Order order) {
        return orderMapper.insertSelective(order);
    }

    @Override
    public int pay(Integer orderId) {
        return orderMapper.pay(orderId);
    }
}
