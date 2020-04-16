package com.gdou.auction.pojo;

import java.util.HashMap;
import java.util.Map;

/**
 * @author hua
 * @date 2020/3/23 - 15:05
 */
public class Msg {
    /**
     * 100成功，200失败
     */
    private int code;
    private String message;
    private Map<String,Object> extend = new HashMap<>();

    public Msg add(String key, Object value){
        this.getExtend().put(key,value);
        return this;
    }

    public static Msg success(){
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMessage("操作成功");
        return msg;
    }

    public static Msg fail(){
        Msg msg = new Msg();
        msg.setMessage("操作失败");
        msg.setCode(200);
        return msg;
    }


    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
