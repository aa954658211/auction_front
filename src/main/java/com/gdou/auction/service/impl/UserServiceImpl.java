package com.gdou.auction.service.impl;

import com.gdou.auction.mapper.UserMapper;
import com.gdou.auction.pojo.User;
import com.gdou.auction.service.UserService;
import com.gdou.auction.utill.PasswordHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author hua
 * @date 2020/4/8 - 15:05
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    private PasswordHelper passwordHelper = new PasswordHelper();

    @Override
    public User findUserByUsername(String username) {
        return userMapper.findUserByUsername(username);
    }

    @Override
    public int save(User user) {
        //先密码加密
        passwordHelper.encryptPassword(user);
        return userMapper.insertSelective(user);
    }

    @Override
    public int update(User user) {
        return userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public User findUserByUserId(Integer userId) {
        return userMapper.selectByPrimaryKey(userId);
    }
}
