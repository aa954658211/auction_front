package com.gdou.auction.controller;

import org.apache.shiro.authc.AuthenticationException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import java.util.HashMap;
import java.util.Map;

/**
 * @author hua
 * @date 2020/3/23 - 10:45
 */
@ControllerAdvice
public class CommonExceptionController {

    @ExceptionHandler(AuthenticationException.class)
    public ModelAndView handlerAuthenticationException(AuthenticationException e){
        Map<String,Object> map = new HashMap<>();
        map.put("message",e.getMessage());
        map.put("code", 1);
        map.put("error","用户名或密码错误");
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addAllObjects(map);
        modelAndView.setView(new MappingJackson2JsonView());
        return modelAndView;
    }

    @ExceptionHandler
    public ModelAndView otherException(Throwable throwable){
        Map<String,Object> map = new HashMap<>();
        map.put("message",throwable.getMessage());
        map.put("code", HttpStatus.INTERNAL_SERVER_ERROR);
        map.put("error","服务器内部错误");
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addAllObjects(map);
        modelAndView.addObject("exception",throwable);
        modelAndView.setViewName("error");
        return modelAndView;
    }
}
