package com.gdou.auction.controller;

import com.gdou.auction.pojo.Item;
import com.gdou.auction.pojo.Msg;
import com.gdou.auction.service.ItemService;
import com.gdou.auction.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author hua
 * @date 2020/4/8 - 16:11
 */
@Controller
public class CommonController {

    @Autowired
    private UserService userService;
    @Autowired
    private ItemService itemService;

    /**
     * 去登录页面
     * @return
     */
    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    @PostMapping("/login")
    @ResponseBody
    public Msg login(String username, String password){
        UsernamePasswordToken token = new UsernamePasswordToken(username,password);
        Subject subject = SecurityUtils.getSubject();
        subject.login(token);
        return Msg.success();
    }
    @RequestMapping("/index")
    public String index(Model model){
        List<Item> items = itemService.list();
        model.addAttribute("items",items);
        return "index";
    }
    @PutMapping("/test/{id}")
    @ResponseBody
    public Msg test(@PathVariable Integer id){
        System.out.println(id);
        return Msg.success();
    }
}
