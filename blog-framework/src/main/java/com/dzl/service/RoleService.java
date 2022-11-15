package com.dzl.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dzl.common.ResponseResult;
import com.dzl.domain.Role;
import com.dzl.domain.vo.PageVo;

import java.util.List;


/**
 * (Role)表服务接口
 *
 * @author 都忠良
 * @since 2022-09-22 13:32:49
 */
public interface RoleService extends IService<Role> {



    ResponseResult<PageVo> listAll(Integer pageNum, Integer pageSize, Role role);

    ResponseResult addUser(Role role);

    void updateUser(Role role);

    List<Role> selectRoleAll();

    List<Long> selectRoleIdByUserId(Long userId);

    List<Integer> getRoleMenu(Integer roleId);

    void setRoleMenu(Long roleId, List<Long> menuIds);
}

