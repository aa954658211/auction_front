package com.gdou.auction.service;

import com.gdou.auction.pojo.Order;
import com.gdou.auction.pojo.OrderExample;

import java.util.List;
import java.util.Map;

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
    /**
     * 展示个人订单
     * @param map
     * @return
     */
    List<Order> findListByUserIdAndStatus(Map<String,Object> map);
    /**
     * 查看详情
     * @param orderId
     * @return
     */
    Order get(Integer orderId);

    long count(OrderExample orderExample);

    int confirm(Order order);

    int pay(Integer orderId);
}
