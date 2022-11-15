package com.dzl.service;


import com.dzl.common.ResponseResult;
import com.dzl.domain.User;

public interface BlogLoginService {
    ResponseResult login(User user);

    ResponseResult logout();

}
