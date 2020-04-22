package com.gdou.auction.service.impl;

import com.gdou.auction.mapper.OrderMapper;
import com.gdou.auction.pojo.Order;
import com.gdou.auction.pojo.OrderExample;
import com.gdou.auction.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author hua
 * @date 2020/4/20 - 10:22
 */
@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderMapper orderMapper;

    @Override
    public List<Order> findListByUserIdAndName(OrderExample orderExample) {
        return orderMapper.selectByExample(orderExample);
    }

    @Override
    public int generate(Order order) {
        return orderMapper.insertSelective(order);
    }
}
