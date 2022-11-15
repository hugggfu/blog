package com.dzl.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dzl.domain.Menu;
import com.dzl.mapper.MenuMapper;
import com.dzl.service.MenuService;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * (Menu)表服务实现类
 *
 * @author 都忠良
 * @since 2022-09-22 13:34:08
 */
@Service("menuService")
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements MenuService {

    @Override
    public List<Menu> findMenus(String name) {
        LambdaQueryWrapper<Menu> queryWrapper = new LambdaQueryWrapper<>();
        if(StringUtils.hasText(name)){
            queryWrapper.eq(Menu::getMenuName,name);
        }
        //排序 parent_id和order_num
        queryWrapper.orderByAsc(Menu::getParentId,Menu::getOrderNum);
        //查询所有数据
        List<Menu> list = list(queryWrapper);
        //找出pid为null的一级菜单

        List<Menu> parentNodes = list.stream().filter(menu -> menu.getParentId().equals(0L)).collect(Collectors.toList());
        // 找出一级菜单的子菜单
//        for (Menu menu : parentNodes) {
//            // 筛选所有数据中pid=父级id的数据就是二级菜单
//            List<Menu> collect = list.stream().filter(m -> menu.getId().equals(m.getParentId())).collect(Collectors.toList());
//            List<Menu> children=getChild(menu.getId(),collect);
//            menu.setChildren(children);
//        }
        parentNodes.forEach(menu->menu.setChildren(getChild(menu.getId(),list)));
        return parentNodes;
    }

    private List<Menu> getChild(Long id, List<Menu> collect) {

//        for (Menu menu : collect) {
//            List<Menu> collect1 = collect.stream()
//                    .filter(m1 -> m1.getParentId().equals(id))
//                    .collect(Collectors.toList());
//            List<Menu> child = getChild(menu.getId(), collect1);
//            menu.setChildren(child);
//        }
        List<Menu> child = collect.stream()
                .filter(menu -> menu.getParentId().equals(id))
                .collect(Collectors.toList());
        if (Objects.isNull(child) || child.size() <= 0) {
            return new ArrayList<>();
        }
        child.forEach(menu->menu.setChildren(getChild(menu.getId(),collect)));


        return child;
    }


    @Override
    public List<Long> selectMenuListByRoleId(List<Long> roleIds) {
        return getBaseMapper().selectMenuListByRoleId(roleIds);
    }
}





