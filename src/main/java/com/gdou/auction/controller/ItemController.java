package com.gdou.auction.controller;

import com.gdou.auction.pojo.Item;
import com.gdou.auction.pojo.ItemType;
import com.gdou.auction.pojo.Msg;
import com.gdou.auction.service.ItemService;
import com.gdou.auction.service.ItemTypeService;
import com.gdou.auction.utill.PathUtil;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

/**
 * @author hua
 * @date 2020/4/13 - 15:33
 */
@RequestMapping("/item")
@Controller
public class ItemController {

    @Autowired
    private ItemTypeService itemTypeService;
    @Autowired
    private ItemService itemService;

    @RequestMapping("/toSale")
    public String toSale(Model model){
        //先查出所有类型
        List<ItemType> types = itemTypeService.getAll();
        model.addAttribute("itemTypes",types);
        return "sale";
    }

    @PostMapping("/sale")
    @ResponseBody
    public Msg sale(Item item, @RequestParam(value = "auctionImg",required = true) MultipartFile file){
        item.setStatus(1);
        String fileName = file.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf("."));
        if (suffix.equalsIgnoreCase(".jpg")
                ||suffix.equalsIgnoreCase(".png")||suffix.equalsIgnoreCase(".jpeg")){
            String uuid = UUID.randomUUID().toString();
            String realPath = PathUtil.IMGPATH;
            File file2 = new File(realPath+"/"+uuid+suffix);
            try {
                FileUtils.copyInputStreamToFile(file.getInputStream(),file2);
            } catch (IOException e) {
                e.printStackTrace();
            }finally {
                try {
                    file.getInputStream().close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            //添加item,并设置图片路径
            item.setPicture(uuid+suffix);
            itemService.save(item);
            //创建一个定时器
        }else{
            return Msg.fail();
        }
        return Msg.success();
    }

    @RequestMapping("/detail")
    public String detail(Integer itemId,Model model){
        Item item = itemService.get(itemId);
        model.addAttribute("item",item);
        return "itemDetail";
    }

    @RequestMapping("/toUpdate")
    public String toUpdate(Integer itemId,Model model){
        //先查出所有类型
        List<ItemType> types = itemTypeService.getAll();
        model.addAttribute("itemTypes",types);
        Item item = itemService.get(itemId);
        model.addAttribute("item",item);
        return "itemUpdate";
    }

    @DeleteMapping("/delete/{itemId}")
    @ResponseBody
    public Msg delete(@PathVariable Integer itemId){
        int delete = itemService.delete(itemId);
        if (delete>0){
            return Msg.success();
        }
        return Msg.fail();
    }

    @ResponseBody
    @DeleteMapping("deleteBatch")
    public Msg deleteBatch(String ids){
        int i = itemService.deleteBatch(ids);
        if (i>0){
            return Msg.success();
        }
        return Msg.fail();
    }

    @PostMapping("/update/{itemId}")
    @ResponseBody
    public Msg update(Item item,@RequestParam(value = "auctionImg",required = false) MultipartFile file){
        System.out.println(item);
        //有图片就删除原来的再重新生成，没有就完事了
        if (file!=null){
            //把原来的图片删除掉，再插入新增的图片
            if (item.getPicture() != null){
                File oldFile = new File(PathUtil.IMGPATH+item.getPicture());
                if (oldFile.exists()){
                    oldFile.delete();
                }
            }
            String fileName = file.getOriginalFilename();
            String suffix = fileName.substring(fileName.lastIndexOf("."));
            if (suffix.equalsIgnoreCase(".jpg")
                    ||suffix.equalsIgnoreCase(".png")||suffix.equalsIgnoreCase(".jpeg")){
                String uuid = UUID.randomUUID().toString();
                String realPath = PathUtil.IMGPATH;
                File file2 = new File(realPath+"/"+uuid+suffix);
                try {
                    FileUtils.copyInputStreamToFile(file.getInputStream(),file2);
                } catch (IOException e) {
                    e.printStackTrace();
                }finally {
                    try {
                        file.getInputStream().close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                //设置图片路径
                item.setPicture(uuid+suffix);
            }
        }
        int update = itemService.update(item);
        if (update>0){
            return Msg.success();
        }
        return Msg.fail();
    }

}
