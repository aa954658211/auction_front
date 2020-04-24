package com.gdou.auction.utill;

import com.gdou.auction.pojo.Order;
import com.gdou.auction.service.OrderService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.UUID;

/**
 * @author hua
 * @date 2020/4/13 - 16:46
 */
@ContextConfiguration(locations = "classpath:applicationContext.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class FileTest {
    @Autowired
    private OrderService orderService;
    @Test
    public void test(){
        Order order = new Order();
        order.setCreateTime(new Date());
        order.setItemId(55);
        order.setPrice(12000);
        order.setOrderNo(UUID.randomUUID().toString());
        order.setStatus(0);
        order.setUserId(35);
        order.setUpdateTime(new Date());
        order.setAddressId(23);
        orderService.generate(order);
    }
}
