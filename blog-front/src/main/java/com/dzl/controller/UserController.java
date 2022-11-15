package com.dzl.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.dzl.common.AppHttpCodeEnum;
import com.dzl.common.ResponseResult;
import com.dzl.domain.User;
import com.dzl.exception.SystemException;
import com.dzl.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/front/user")
public class UserController {
    @Autowired
    private UserService userService;



    @GetMapping("/username/{username}")
    public ResponseResult findByUsername(@PathVariable String username){
        LambdaQueryWrapper<User> queryWrapper=new LambdaQueryWrapper<>();
        queryWrapper.eq(User::getUserName,username);
        return ResponseResult.okResult(userService.getOne(queryWrapper));
    }

    @PostMapping ("/update")
    public ResponseResult updateByUsername(@RequestBody User user) {
        if(!StringUtils.hasText(user.getNickName())){
            throw new SystemException(AppHttpCodeEnum.NICKNAME_NOT_NULL);
        }
        userService.updateById(user);
        return ResponseResult.okResult();
    }
    @PostMapping("/register")
    public ResponseResult register(@RequestBody User user){
        return userService.register(user);
    }

}
