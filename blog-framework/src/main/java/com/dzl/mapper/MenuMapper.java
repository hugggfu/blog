package com.dzl.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dzl.domain.Menu;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;


/**
 * (Menu)表数据库访问层
 *
 * @author 都忠良
 * @since 2022-09-22 13:34:07
 */
public interface MenuMapper extends BaseMapper<Menu> {

    List<Long> selectMenuListByRoleId(@Param("roleIds") List<Long> roleId);
    List<String> selectPermsByUserId(Long id);
}

