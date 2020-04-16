package com.gdou.auction.realm;

import com.gdou.auction.pojo.User;
import com.gdou.auction.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author hua
 * @date 2020/4/8 - 14:45
 */
public class UserRealm extends AuthorizingRealm {
    @Autowired
    private UserService userService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {

        String username = (String) token.getPrincipal();
        User user = userService.findUserByUsername(username);
        if (user == null){
            throw new UnknownAccountException("用户名或密码错误");
        }
        String credentials =new String((char[]) token.getCredentials()) ;
        SimpleHash simpleHash = new SimpleHash("MD5",credentials,user.getSalt(),2);
        credentials = simpleHash.toHex();
        if (!user.getPassword().equals(credentials)){
            throw new IncorrectCredentialsException("用户名或密码错误");
        }
        SimpleAuthenticationInfo simpleAuthenticationInfo =
                new SimpleAuthenticationInfo(
                        user,//用户名
                        user.getPassword(),//密码
                        ByteSource.Util.bytes(user.getSalt()),//盐值
                        getName());//realm名
        return simpleAuthenticationInfo;
    }
}
