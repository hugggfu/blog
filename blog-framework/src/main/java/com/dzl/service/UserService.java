package com.dzl.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dzl.common.ResponseResult;

import com.dzl.domain.Dto.UserPasswordDTO;
import com.dzl.domain.User;
import com.dzl.domain.vo.PageVo;
import com.dzl.domain.Dto.UserInfoDto;


/**
 * (User)表服务接口
 *
 * @author 都忠良
 * @since 2022-09-22 13:30:42
 */
public interface UserService extends IService<User> {

    ResponseResult<PageVo> listAll(Integer pageNum, Integer pageSize, UserInfoDto userInfoDto);

    boolean checkUserNameUnique(String userName);

    boolean checkEmailUnique(User user);

    ResponseResult addUser(User user);

    void updateUser(User user);


    void updatePassword(UserPasswordDTO userPasswordDTO);

    ResponseResult register(User user);
}

