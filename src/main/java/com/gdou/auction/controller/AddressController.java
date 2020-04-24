package com.gdou.auction.controller;

import com.gdou.auction.pojo.Address;
import com.gdou.auction.pojo.Msg;
import com.gdou.auction.service.AddressService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * @author hua
 * @date 2020/4/23 - 15:19
 */
@Controller
@RequestMapping("/address")
public class AddressController {

    @Autowired
    private AddressService addressService;

    @RequestMapping("/list")
    public String list(@RequestParam(defaultValue = "1") Integer pageNum,Integer userId, Model model){
        PageHelper.startPage(pageNum,10);
        List<Address> addresses = addressService.getAllByUserId(userId);
        PageInfo pageInfo = new PageInfo(addresses);
        model.addAttribute("pageInfo",pageInfo);
        return "address";
    }

    @PostMapping("/save")
    @ResponseBody
    public Msg save(Address address){
        if (address.getIsDefault() == null){
            address.setIsDefault(2);
        }else{
            //将其他的地址设为非默认地址
            addressService.updateIsDefault(address.getUserId());
        }
        int save = addressService.save(address);
        if (save > 0) {
            return Msg.success();
        }
        return Msg.fail();
    }

    @RequestMapping("/get/{addressId}")
    @ResponseBody
    public Msg get(@PathVariable Integer addressId){
        Address address = addressService.get(addressId);
        return Msg.success().add("address",address);
    }

    @PutMapping("/update/{addressId}")
    @ResponseBody
    public Msg update(Address address){
        if (address.getIsDefault() != null){
            //将其他的地址设为非默认地址
            addressService.updateIsDefault(address.getUserId());
        }else{
            address.setIsDefault(2);
        }
        int update = addressService.update(address);
        if (update >0){
            return Msg.success();
        }
        return Msg.fail();
    }

    @DeleteMapping("/delete/{addressId}")
    @ResponseBody
    public Msg delete(@PathVariable Integer addressId){
        int update = addressService.delete(addressId);
        if (update >0){
            return Msg.success();
        }
        return Msg.fail();
    }

    @DeleteMapping("/deleteBatch")
    @ResponseBody
    public Msg deleteBatch(String addressIds){
        String[] s = addressIds.split(" ");
        List<Integer> list = new ArrayList<>();
        for (String s1 : s) {
            int i = Integer.parseInt(s1);
            list.add(i);
        }
        int deleteBatch = addressService.deleteBatch(list);
        if (deleteBatch > 0){
            return Msg.success();
        }
        return Msg.fail();
    }

}
