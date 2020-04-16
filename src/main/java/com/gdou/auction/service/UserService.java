package com.gdou.auction.service;

import com.gdou.auction.pojo.User;

/**
 * @author hua
 * @date 2020/4/8 - 15:04
 */
public interface UserService {
    User findUserByUsername(String username);

    int save(User user);

    User findUserByUserId(Integer userId);

    int update(User user);
}
