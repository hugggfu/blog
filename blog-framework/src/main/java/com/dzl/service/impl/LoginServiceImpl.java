package com.dzl.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.dzl.common.AppHttpCodeEnum;
import com.dzl.common.ResponseResult;
import com.dzl.common.Result;
import com.dzl.domain.LoginUser;
import com.dzl.domain.Menu;
import com.dzl.domain.User;
import com.dzl.mapper.RoleMapper;
import com.dzl.mapper.RoleMenuMapper;
import com.dzl.service.*;
import com.dzl.utils.JwtUtil;
import com.dzl.utils.RedisCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class LoginServiceImpl implements LoginService {
    @Autowired
    private AuthenticationManager authenticationManager;
   @Autowired
   private RoleService roleService;
   @Autowired
   private MenuService menuService;
   @Autowired
   private RoleMapper roleMapper;
    @Autowired
    private RedisCache redisCache;
    @Override
    public ResponseResult login(User user) {
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(user.getUserName(), user.getPassword());
        Authentication authenticate = authenticationManager.authenticate(authenticationToken);
        //判断认证是否通过
        if (Objects.isNull(authenticate)) {
            throw new RuntimeException("用户名或密码错误");
        }

        //获取userid 生成token
        LoginUser loginUser = (LoginUser) authenticate.getPrincipal();
        String userId = loginUser.getUser().getId().toString();


        String jwt = JwtUtil.createJWT(userId);
        //把用户信息存入redis
        redisCache.setCacheObject("login:" + userId, loginUser);
        //把token封装 返回
        user.setToken(jwt);
        List<Long> roleIds = roleService.selectRoleIdByUserId(loginUser.getUser().getId());
        List<Long> menuIds = menuService.selectMenuListByRoleId(roleIds);
        menuService.findMenus("");
        //查出系统所有的菜单
        List<Menu> menus = menuService.findMenus("");
        //new一个最后筛选完成的list
        List<Menu> roleMenus = new ArrayList<>();
        //筛选当前用户的菜单
        for (Menu menu : menus) {
            if (menuIds.contains(menu.getId())) {
                roleMenus.add(menu);
            }
            List<Menu> children = menu.getChildren();
            // removeIf()  移除 children 里面不在 menuIds集合中的 元素
            children.removeIf(child -> !menuIds.contains(child.getId()));
            user.setMenus(roleMenus);
        }
        user.setNickName(loginUser.getUser().getNickName());
        user.setAvatar(loginUser.getUser().getAvatar());
        return ResponseResult.okResult(user);
    }
}
