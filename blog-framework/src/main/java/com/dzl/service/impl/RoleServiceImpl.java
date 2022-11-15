package com.dzl.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dzl.common.AppHttpCodeEnum;
import com.dzl.common.ResponseResult;
import com.dzl.common.SystemConstants;
import com.dzl.domain.Menu;
import com.dzl.domain.Role;
import com.dzl.domain.RoleMenu;
import com.dzl.domain.vo.PageVo;
import com.dzl.exception.SystemException;
import com.dzl.mapper.RoleMapper;
import com.dzl.mapper.RoleMenuMapper;
import com.dzl.service.RoleMenuService;
import com.dzl.service.RoleService;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

/**
 * (Role)表服务实现类
 *
 * @author 都忠良
 * @since 2022-09-22 13:32:50
 */
@Service("roleService")
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {
    @Resource
    private RoleMenuMapper roleMenuMapper;
    @Resource
    private MenuServiceImpl menuService;
    @Resource
    private RoleMenuService roleMenuService;
    @Override
    public ResponseResult<PageVo> listAll(Integer pageNum, Integer pageSize, Role role) {
        LambdaQueryWrapper<Role> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        //目前没有根据id查询
//        lambdaQueryWrapper.eq(Objects.nonNull(role.getId()),Role::getId,role.getId());
        lambdaQueryWrapper.like(StringUtils.hasText(role.getRoleName()),Role::getRoleName,role.getRoleName());
        lambdaQueryWrapper.orderByAsc(Role::getRoleSort);

        Page<Role> page = new Page<>();
        page.setCurrent(pageNum);
        page.setSize(pageSize);
        page(page,lambdaQueryWrapper);
        //封装数据返回
        PageVo pageVo = new PageVo(page.getRecords(),page.getTotal());
        return ResponseResult.okResult(pageVo);
    }

    @Override
    public ResponseResult addUser(Role role) {
        if(Objects.isNull(role.getRoleName())){
            throw new SystemException(AppHttpCodeEnum.REQUIRE_ROLENAME);
        }
        save(role);
        return ResponseResult.okResult();
    }

    @Override
    public void updateUser(Role role) {
          updateById(role);
    }

    @Override
    public List<Role> selectRoleAll() {
        return list(Wrappers.<Role>lambdaQuery().eq(Role::getStatus, SystemConstants.NORMAL));
    }

    @Override
    public List<Long> selectRoleIdByUserId(Long userId) {
        return getBaseMapper().selectRoleIdByUserId(userId);
    }

    @Override
    public List<Integer> getRoleMenu(Integer roleId) {

        return roleMenuMapper.selectByRoleId(roleId);
    }

    @Override
    public void setRoleMenu(Long roleId, List<Long> menuIds) {
// 先删除当前角色id所有的绑定关系
        roleMenuService.deleteRoleMenuByRoleId(roleId);
        // 再把前端传过来的菜单id数组绑定到当前的这个角色id上去
        List<Long> menuIdsCopy = CollUtil.newArrayList(menuIds);
        for (Long menuId : menuIds) {
            Menu menu = menuService.getById(menuId);
            if (menu.getParentId() != null && !menuIdsCopy.contains(menu.getParentId())) { // 二级菜单 并且传过来的menuId数组里面没有它的父级id
                // 那么我们就得补上这个父级id
                RoleMenu roleMenu = new RoleMenu();
                roleMenu.setRoleId(roleId);
                roleMenu.setMenuId(menu.getParentId());
                roleMenuMapper.insert(roleMenu);
                menuIdsCopy.add(menu.getParentId());
            }
            RoleMenu roleMenu = new RoleMenu();
            roleMenu.setRoleId(roleId);
            roleMenu.setMenuId(menuId);
            roleMenuMapper.insert(roleMenu);
        }
    }
}

