package com.dzl.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dzl.domain.RoleMenu;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import java.util.List;


/**
 * (RoleMenu)表数据库访问层
 *
 * @author 都忠良
 * @since 2022-09-22 13:36:56
 */

public interface RoleMenuMapper extends BaseMapper<RoleMenu> {
    @Delete("delete from sys_role_menu where role_id =#{roleId}")
    int deleteByRoleId(Integer roleId);
    @Select("select menu_id from sys_role_menu where role_id = #{roleId}")
    List<Integer> selectByRoleId(Integer roleId);
}

