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
 * @date 2020/4/23 - 17:51
 */
@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderMapper orderMapper;

    @Override
    public Order get(Integer orderId) {
        return orderMapper.selectByPrimaryKey(orderId);
    }

    @Override
    public List<Order> findListByUserIdAndName(OrderExample orderExample) {
        return orderMapper.selectByExample(orderExample);
    }

    @Override
    public int generate(Order order) {
        return orderMapper.insertSelective(order);
    }
}
