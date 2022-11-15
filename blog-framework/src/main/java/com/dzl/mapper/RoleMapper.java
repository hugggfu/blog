package com.dzl.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dzl.domain.Role;

import java.util.List;


/**
 * (Role)表数据库访问层
 *
 * @author 都忠良
 * @since 2022-09-22 13:32:48
 */

public interface RoleMapper extends BaseMapper<Role> {

    List<Long> selectRoleIdByUserId(Long userId);
}

