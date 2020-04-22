package com.gdou.auction.utill;

import java.io.File;

/**
 * @author hua
 * @date 2020/4/13 - 16:46
 */
public class FileTest {
    public static void main(String[] args) {
        File file = new File(PathUtil.IMGPATH+"jianke.jpg");
        if (file.isFile()){
            System.out.println("234");
        }
    }
}
