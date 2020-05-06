package com.gdou.auction.utill;

import com.gdou.auction.pojo.Order;
import com.gdou.auction.service.OrderService;
import com.gdou.auction.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author hua
 * @date 2020/4/13 - 16:46
 */
@ContextConfiguration(locations = "classpath:applicationContext.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class FileTest {
    @Autowired
    private OrderService orderService;
    @Autowired
    private UserService userService;

    @Test
    public void test(){
        Integer status=1,userId=35;
        Map<String,Object> map = new HashMap();
        map.put("userId",userId);
        if (status != null){
            map.put("status",status);
        }
        List<Order> list = orderService.findListByUserIdAndStatus(map);
        System.out.println(list.size());
    }

    @Test
    public void test2(){
        System.out.println(userService.findBalance(35));
    }
}
