package com.dzl.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dzl.domain.Menu;

import java.util.List;


/**
 * (Menu)表服务接口
 *
 * @author 都忠良
 * @since 2022-09-22 13:34:08
 */
public interface MenuService extends IService<Menu> {

    List<Menu> findMenus(String name);
    List<Long> selectMenuListByRoleId(List<Long> roleIds);
}

