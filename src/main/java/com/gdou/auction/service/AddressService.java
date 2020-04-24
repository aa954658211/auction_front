package com.gdou.auction.service;

import com.gdou.auction.pojo.Address;

import java.util.List;

/**
 * @author hua
 * @date 2020/4/23 - 15:14
 */
public interface AddressService {
    int save(Address address);

    /**
     * 更新是否默认地址
     * @param userId
     * @return
     */
    int updateIsDefault(Integer userId);
    List<Address> getAllByUserId(Integer userId);
    Address get(Integer addressId);
    int update(Address address);
    int delete(Integer addressId);
    int deleteBatch(List<Integer> addressIds);
    Address findDefaultByUserId(Integer userId);
}
