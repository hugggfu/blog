package com.dzl.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dzl.domain.RoleMenu;


/**
 * (RoleMenu)表服务接口
 *
 * @author 都忠良
 * @since 2022-09-22 13:36:56
 */
public interface RoleMenuService extends IService<RoleMenu> {

    void deleteRoleMenuByRoleId(Long roleId);
}

