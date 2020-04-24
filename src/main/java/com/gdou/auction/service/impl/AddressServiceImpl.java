package com.gdou.auction.service.impl;

import com.gdou.auction.mapper.AddressMapper;
import com.gdou.auction.pojo.Address;
import com.gdou.auction.pojo.AddressExample;
import com.gdou.auction.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author hua
 * @date 2020/4/23 - 15:14
 */
@Service
public class AddressServiceImpl implements AddressService {

    @Autowired
    private AddressMapper addressMapper;

    @Override
    public List<Address> getAllByUserId(Integer userId) {
        AddressExample addressExample = new AddressExample();
        addressExample.createCriteria().andUserIdEqualTo(userId);
        return addressMapper.selectByExample(addressExample);
    }

    @Override
    public Address get(Integer addressId) {
        return addressMapper.selectByPrimaryKey(addressId);
    }

    @Override
    public int update(Address address) {
        return addressMapper.updateByPrimaryKeySelective(address);
    }

    @Override
    public int updateIsDefault(Integer userId) {
        return addressMapper.updateIsDefault(userId);
    }

    @Override
    public int save(Address address) {
        return addressMapper.insertSelective(address);
    }
    @Override
    public int delete(Integer addressId) {
        return addressMapper.deleteByPrimaryKey(addressId);
    }

    @Override
    public int deleteBatch(List<Integer> addressIds) {
        AddressExample addressExample = new AddressExample();
        addressExample.createCriteria().andAddressIdIn(addressIds);
        return addressMapper.deleteByExample(addressExample);
    }

    @Override
    public Address findDefaultByUserId(Integer userId) {
        return addressMapper.findDefaultByUserId(userId);
    }
}
