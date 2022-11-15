package com.dzl.controller;

import com.dzl.common.ResponseResult;
import com.dzl.common.Result;
import com.dzl.domain.User;
import com.dzl.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController

public class LoginController {
    @Autowired
    private LoginService loginService;

    @PostMapping("/user/login")
    public ResponseResult Login(@RequestBody User user){

        return loginService.login(user);
    }
}
