package com.dzl.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.dzl.common.AppHttpCodeEnum;
import com.dzl.common.ResponseResult;
import com.dzl.domain.Dto.UserPasswordDTO;
import com.dzl.domain.Role;
import com.dzl.domain.User;
import com.dzl.domain.vo.PageVo;
import com.dzl.domain.vo.UserInfoAndRoleIdsVo;
import com.dzl.domain.Dto.UserInfoDto;
import com.dzl.exception.SystemException;
import com.dzl.service.RoleService;
import com.dzl.service.UserService;
import com.dzl.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController

@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;
    @GetMapping("/listAll")
    @PreAuthorize("hasAuthority('sys:user:list')")
    public  ResponseResult listAll(){
        return ResponseResult.okResult(userService.list()) ;
    }

    @GetMapping("/list")
    @PreAuthorize("hasAuthority('sys:user:list')")
    public ResponseResult<PageVo> list( Integer pageNum,  Integer pageSize, UserInfoDto userInfoDto){
        return userService.listAll(pageNum,pageSize,userInfoDto);
    }
    @PostMapping("")
    @PreAuthorize("hasAuthority('sys:user:save')")
    public ResponseResult add(@RequestBody User user){
        if(!StringUtils.hasText(user.getUserName())){
            throw new SystemException(AppHttpCodeEnum.REQUIRE_USERNAME);
        }
        if (!userService.checkUserNameUnique(user.getUserName())){
            throw new SystemException(AppHttpCodeEnum.USERNAME_EXIST);
        }
        if (!userService.checkEmailUnique(user)){
            throw new SystemException(AppHttpCodeEnum.EMAIL_EXIST);
        }
         return userService.addUser(user);
    }
    @PutMapping
    @PreAuthorize("hasAuthority('sys:user:edit')")
    public ResponseResult edit(@RequestBody User user) {
        userService.updateUser(user);
        return ResponseResult.okResult();
    }
    @PostMapping ("/update")
    public ResponseResult updateByUsername(@RequestBody User user) {
        if(!StringUtils.hasText(user.getNickName())){
           throw new SystemException(AppHttpCodeEnum.NICKNAME_NOT_NULL);
        }
        userService.updateById(user);
        return ResponseResult.okResult();
    }
    @DeleteMapping("/{id}")
    @PreAuthorize("hasAuthority('sys:user:delete')")
    public ResponseResult delete(@PathVariable Integer id) {
        userService.removeById(id);
        return ResponseResult.okResult();
    }


    @PostMapping("/{userIds}")
    @PreAuthorize("hasAuthority('sys:user:delete')")
    public ResponseResult remove(@PathVariable List<Long> userIds) {
        if(userIds.contains(SecurityUtils.getUserId())){
            return ResponseResult.errorResult(500,"不能删除当前你正在使用的用户");
        }
        userService.removeByIds(userIds);
        return ResponseResult.okResult();
    }
    /**
     * 根据用户编号获取详细信息
     */
    @GetMapping(value = {"/{userId}"})
    public ResponseResult getUserInfoAndRoleIds(@PathVariable(value = "userId") Long userId){
        List<Role> roles = roleService.selectRoleAll();
        User user = userService.getById(userId);
        //当前用户所具有的角色id列表
        List<Long> roleIds = roleService.selectRoleIdByUserId(userId);
        UserInfoAndRoleIdsVo vo = new UserInfoAndRoleIdsVo(user,roles,roleIds);
        return ResponseResult.okResult(vo);
    }
    @GetMapping("/username/{username}")
    public ResponseResult findByUsername(@PathVariable String username){
        LambdaQueryWrapper<User> queryWrapper=new LambdaQueryWrapper<>();
        queryWrapper.eq(User::getUserName,username);
        return ResponseResult.okResult(userService.getOne(queryWrapper));
    }
    /**
     * 修改密码
     * @param userPasswordDTO
     * @return
     */
    @PostMapping("/password")
    public ResponseResult password(@RequestBody UserPasswordDTO userPasswordDTO) {

        userService.updatePassword(userPasswordDTO);
        return ResponseResult.okResult();
    }

}
