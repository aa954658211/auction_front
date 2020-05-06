package com.gdou.auction.controller;

import com.gdou.auction.pojo.Item;
import com.gdou.auction.pojo.ItemExample;
import com.gdou.auction.pojo.Msg;
import com.gdou.auction.pojo.User;
import com.gdou.auction.service.ItemService;
import com.gdou.auction.service.OrderService;
import com.gdou.auction.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author hua
 * @date 2020/4/10 - 10:43
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private ItemService itemService;
    @Autowired
    private OrderService orderService;

    @PostMapping("/save")
    @ResponseBody
    public Msg save(User user){
        if (user.getUsername() == null){
            return Msg.fail();
        }
        user.setStatus(1);
        user.setCreateTime(new Date());
        int i = userService.save(user);
        if (i>0){
            return Msg.success();
        }
        return Msg.fail();
    }

    @RequestMapping("/toDetail")
    public String toDetail(Integer userId, Model model){
        User user = userService.findUserByUserId(userId);
        model.addAttribute("user",user);
        return "detail";
    }

    @PostMapping("/update")
    public String update(User user){
        int i = userService.update(user);
        return "redirect:/user/toDetail?userId="+user.getUserId();
    }

    @RequestMapping("/mySale")
    public String mySale(){
        return "mySale";
    }

    @RequestMapping("/saleData")
    @ResponseBody
    public Map<String,Object> mySale(Integer userId, String name){
        Map<String,Object> map = new HashMap();
        ItemExample itemExample = new ItemExample();
        ItemExample.Criteria criteria = itemExample.createCriteria();
        criteria.andUserIdEqualTo(userId);
        if (name!=null && name!=""){
            criteria.andNameEqualTo(name);
        }
        List<Item> items = itemService.findListByUserIdAndName(itemExample);
        Long total = itemService.count(itemExample);
        map.put("rows",items);
        map.put("total",total);
        return map;
    }

    @RequestMapping("/balance")
    @ResponseBody
    public Msg balance(Integer userId){
        Integer balance = userService.findBalance(userId);
        return Msg.success().add("balance",balance);
    }

    @PostMapping("/pay")
    @ResponseBody
    public Msg pay(Integer userId,Integer price,Integer orderId){
        //完成付款操作,先将买家定金扣取，并且更改状态，收货后再将定金发送到卖家
        int pay = userService.pay(userId, price);
        orderService.pay(orderId);
        if (pay>0)
            return Msg.success();
        return Msg.fail();
    }
}
