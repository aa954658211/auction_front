package com.gdou.auction.service;

import com.gdou.auction.pojo.Item;
import com.gdou.auction.pojo.ItemExample;

import java.util.List;

/**
 * @author hua
 * @date 2020/4/11 - 21:38
 */
public interface ItemService {
    /**
     * 新增拍卖品
     * @param item
     * @return
     */
    int save(Item item);

    /**
     * 删除拍卖品
     * @param itemId
     * @return
     */
    int delete(Integer itemId);

    /**
     * 修改拍卖品
     * @param item
     * @return
     */
    int update(Item item);

    /**
     * 查出所有上传的拍卖品
     * @return
     */
    List<Item> list();

    Item get(Integer itemId);

    List<Item> findListByUserIdAndName(ItemExample itemExample);

    /**
     * 返回总记录数
     * @return
     */
    long count(ItemExample itemExample);

    int deleteBatch(String ids);
}
