package com.gdou.auction.service;

import com.gdou.auction.pojo.Order;
import com.gdou.auction.pojo.OrderExample;

import java.util.List;

/**
 * @author hua
 * @date 2020/4/23 - 17:50
 */
public interface OrderService {
    /**
     * 生产订单
     * @param order
     * @return
     */
    int generate(Order order);

    List<Order> findListByUserIdAndName(OrderExample orderExample);

    Order get(Integer orderId);
}
