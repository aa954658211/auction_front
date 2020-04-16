package com.gdou.auction.service.impl;

import com.gdou.auction.mapper.ItemTypeMapper;
import com.gdou.auction.pojo.ItemType;
import com.gdou.auction.service.ItemTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author hua
 * @date 2020/4/13 - 15:31
 */
@Service
public class ItemTypeServiceImpl implements ItemTypeService {
    @Autowired
    private ItemTypeMapper itemTypeMapper;

    @Override
    public List<ItemType> getAll() {
        return itemTypeMapper.selectByExample(null);
    }
}
