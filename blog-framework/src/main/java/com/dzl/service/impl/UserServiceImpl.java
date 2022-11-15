package com.dzl.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dzl.common.AppHttpCodeEnum;
import com.dzl.common.ResponseResult;
import com.dzl.domain.Dto.UserPasswordDTO;
import com.dzl.domain.User;
import com.dzl.domain.UserRole;
import com.dzl.domain.vo.PageVo;
import com.dzl.domain.Dto.UserInfoDto;
import com.dzl.exception.SystemException;
import com.dzl.mapper.UserMapper;
import com.dzl.service.UserRoleService;
import com.dzl.service.UserService;
import com.dzl.utils.BeanCopyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * (User)表服务实现类
 *
 * @author 都忠良
 * @since 2022-09-22 13:30:43
 */
@Service("userService")
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {
    @Resource
    private UserMapper userMapper;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private UserRoleService userRoleService;
    @Override
    public ResponseResult<PageVo> listAll(Integer pageNum, Integer pageSize, UserInfoDto userInfoDto) {

        LambdaQueryWrapper<User> lambdaQueryWrapper=new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(StringUtils.hasText(userInfoDto.getUserName()),User::getUserName,userInfoDto.getUserName());
        lambdaQueryWrapper.eq(StringUtils.hasText(userInfoDto.getEmail()),User::getEmail,userInfoDto.getEmail());
        Page<User> page=new Page<>();
        page.setCurrent(pageNum);
        page.setSize(pageSize);
        page(page,lambdaQueryWrapper);
        //封装数据返回
        PageVo pageVo = new PageVo(page.getRecords(),page.getTotal());
        return ResponseResult.okResult(pageVo);

    }

    @Override
    public boolean checkUserNameUnique(String userName) {
        return count(Wrappers.<User>lambdaQuery().eq(User::getUserName,userName))==0;

    }

    @Override
    public boolean checkEmailUnique(User user) {
        return count(Wrappers.<User>lambdaQuery().eq(User::getEmail,user.getEmail()))==0;

    }

    @Override
    @Transactional
    public ResponseResult addUser(User user) {
        if(Objects.isNull(user.getPassword())){
            throw new SystemException(AppHttpCodeEnum.PASSWORD_NOT_NULL);
        }
       user.setPassword(passwordEncoder.encode(user.getPassword()));
        save(user);
        if(user.getRoleIds()!=null&&user.getRoleIds().length>0){
            insertUserRole(user);
        }

        return ResponseResult.okResult();
    }

    private void insertUserRole(User user) {
        List<UserRole> collect = Arrays.stream(user.getRoleIds())
                .map(new Function<Long, UserRole>() {
                    @Override
                    public UserRole apply(Long roleId) {
                        return new UserRole(user.getId(), roleId);
                    }
                })
                .collect(Collectors.toList());
         userRoleService.saveBatch(collect);
    }

    @Override
    @Transactional
    public void updateUser(User user) {
        // 删除用户与角色关联
        LambdaQueryWrapper<UserRole> userRoleUpdateWrapper = new LambdaQueryWrapper<>();
        userRoleUpdateWrapper.eq(UserRole::getUserId,user.getId());
        userRoleService.remove(userRoleUpdateWrapper);
        // 新增用户与角色管理
        insertUserRole(user);
        // 更新用户信息
        updateById(user);
    }

    @Override
    public void updatePassword(UserPasswordDTO userPasswordDTO) {
        LambdaQueryWrapper<User> lambdaQueryWrapper=new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(User::getUserName,userPasswordDTO.getUserName());
        User user = userMapper.selectOne(lambdaQueryWrapper);
        userPasswordDTO.setId(user.getId());
        if(passwordEncoder.matches(userPasswordDTO.getPassword(),user.getPassword())){
            userPasswordDTO.setPassword(passwordEncoder.encode(userPasswordDTO.getNewPassword()));
            User user1 = BeanCopyUtils.copyBean(userPasswordDTO, User.class);
            userMapper.updateById(user1);
       }else {
            throw new SystemException(AppHttpCodeEnum.PASSWORD_ERROR);
        }

    }

    @Override
    public ResponseResult register(User user) {
        if(!StringUtils.hasText(user.getUserName())){
            throw new SystemException(AppHttpCodeEnum.USERNAME_NOT_NULL);
        }
        if(!StringUtils.hasText(user.getPassword())){
            throw new SystemException(AppHttpCodeEnum.PASSWORD_NOT_NULL);
        }
        if(!StringUtils.hasText(user.getEmail())){
            throw new SystemException(AppHttpCodeEnum.EMAIL_NOT_NULL);
        }
        if(!StringUtils.hasText(user.getNickName())){
            throw new SystemException(AppHttpCodeEnum.NICKNAME_NOT_NULL);
        }
        //对数据进行是否存在的判断
        if(userNameExist(user.getUserName())){
            throw new SystemException(AppHttpCodeEnum.USERNAME_EXIST);
        }
        if(nickNameExist(user.getNickName())){
            throw new SystemException(AppHttpCodeEnum.NICKNAME_EXIST);
        }
        //...
        //对密码进行加密
        String encodePassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encodePassword);
        //存入数据库
        save(user);
        if(user.getRoleIds()==null){
           Long [] longs={2L};
           user.setRoleIds(longs);
            insertUserRole(user);
        }

        return ResponseResult.okResult();
    }
    private boolean nickNameExist(String nickName) {
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(User::getNickName,nickName);
        return count(queryWrapper)>0;
    }

    private boolean userNameExist(String userName) {
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(User::getUserName,userName);
        return count(queryWrapper)>0;
    }

}

