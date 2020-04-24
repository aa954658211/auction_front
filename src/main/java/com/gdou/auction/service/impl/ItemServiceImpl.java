package com.gdou.auction.service.impl;

import com.gdou.auction.mapper.ItemMapper;
import com.gdou.auction.pojo.Item;
import com.gdou.auction.pojo.ItemExample;
import com.gdou.auction.service.ItemService;
import com.gdou.auction.utill.PathUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.Date;
import java.util.List;

/**
 * @author hua
 * @date 2020/4/11 - 21:41
 */

@Service
public class ItemServiceImpl implements ItemService {

    @Autowired
    private ItemMapper itemMapper;

    @Override
    public int save(Item item) {
        return itemMapper.insertSelective(item);
    }

    @Override
    public int delete(Integer itemId) {
        //删除图片
        Item item = get(itemId);
        File file = new File(PathUtil.IMGPATH+item.getPicture());
        if (file.exists()){
            file.delete();
        }
        return itemMapper.deleteByPrimaryKey(itemId);
    }

    @Override
    public int update(Item item) {
        return itemMapper.updateByPrimaryKeySelective(item);
    }

    @Override
    public Item get(Integer itemId) {
        return itemMapper.selectByPrimaryKeyWithItemType(itemId);
    }

    @Override
    public long count(ItemExample itemExample) {
        return itemMapper.countByExample(itemExample);
    }

    @Override
    public List<Item> findListByUserIdAndName(ItemExample itemExample) {
        return itemMapper.selectByExampleWithItemType(itemExample);
    }

    @Override
    public List<Item> list() {
        ItemExample itemExample = new ItemExample();
        itemExample.createCriteria().andEndTimeGreaterThanOrEqualTo(new Date());
        return itemMapper.selectByExampleWithItemType(itemExample);
    }
    @Override
    public int updateStatusByUserIdAndItemId(Item item) {
        ItemExample itemExample = new ItemExample();
        ItemExample.Criteria criteria = itemExample.createCriteria();
        criteria.andUserIdEqualTo(item.getUserId()).andItemIdEqualTo(item.getItemId());
        return itemMapper.updateByExampleSelective(item,itemExample);
    }

    @Override
    public int deleteBatch(String ids) {
        String[] split = ids.split(",");
        for (String s : split) {
            delete(Integer.parseInt(s));
        }
        return 1;
    }
}
