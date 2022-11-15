package com.dzl.service;

import com.dzl.common.ResponseResult;
import com.dzl.common.Result;
import com.dzl.domain.User;

public interface LoginService {
    ResponseResult login(User user);
}
