package com.gdou.auction.controller;

import com.gdou.auction.pojo.Address;
import com.gdou.auction.pojo.Msg;
import com.gdou.auction.pojo.Order;
import com.gdou.auction.service.AddressService;
import com.gdou.auction.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author hua
 * @date 2020/4/22 - 11:03
 */
@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private AddressService addressService;

    @GetMapping
    public String order(){
        return "order";
    }

    @PostMapping("/list")
    @ResponseBody
    public Msg list(Integer userId, Integer status){
        Map<String,Object> map = new HashMap();
        map.put("userId",userId);
        if (status != null){
            map.put("status",status);
        }
        List<Order> list = orderService.findListByUserIdAndStatus(map);
        return Msg.success().add("orders",list);
    }

    /**
     * 根据什么来确认订单，并且确认订单前要选择地址
     * @return
     */
    @PostMapping("/confirm")
    @ResponseBody
    public Msg confirm(Integer orderId,Integer addressId){
        Order order = new Order();
        order.setOrderId(orderId);
        order.setAddressId(addressId);
        order.setStatus(0);
        order.setUpdateTime(new Date());
        int confirm = orderService.confirm(order);
        if (confirm!=0){
            return Msg.success();
        }
        return Msg.fail();
    }

    @GetMapping("/orderDetail")
    public String orderDetail(Integer orderId,Integer userId,Model model){
        Order order = orderService.get(orderId);
        List<Address> addresses = addressService.getAllByUserId(userId);
        model.addAttribute("addresses",addresses);
        model.addAttribute("order",order);
        return "orderDetail";
    }
}
