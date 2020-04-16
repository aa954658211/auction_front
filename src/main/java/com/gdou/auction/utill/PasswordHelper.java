package com.gdou.auction.utill;

import com.gdou.auction.pojo.User;
import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.stereotype.Component;

/**
 * @author hua
 * @date 2020/3/24 - 10:31
 */
@Component
public class PasswordHelper {
    //生产一个随机数
    private RandomNumberGenerator randomNumberGenerator = new SecureRandomNumberGenerator();
    //加密算法名称
    private String algorithName = "MD5";
    //散列迭代次数
    private int hashInteration = 2;

    public void encryptPassword(User user){
        if (user.getPassword()!= null){
            user.setSalt(randomNumberGenerator.nextBytes().toHex());
            SimpleHash simpleHash = new SimpleHash(algorithName,user.getPassword(), ByteSource.Util.bytes(user.getSalt()),hashInteration);
            String newPassword = simpleHash.toHex();
            user.setPassword(newPassword);
        }
    }

    public RandomNumberGenerator getRandomNumberGenerator() {
        return randomNumberGenerator;
    }

    public void setRandomNumberGenerator(RandomNumberGenerator randomNumberGenerator) {
        this.randomNumberGenerator = randomNumberGenerator;
    }

    public String getAlgorithName() {
        return algorithName;
    }

    public void setAlgorithName(String algorithName) {
        this.algorithName = algorithName;
    }

    public int getHashInteration() {
        return hashInteration;
    }

    public void setHashInteration(int hashInteration) {
        hashInteration = hashInteration;
    }
}
