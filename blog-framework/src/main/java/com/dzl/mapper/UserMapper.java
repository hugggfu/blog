package com.dzl.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dzl.domain.Dto.UserPasswordDTO;
import com.dzl.domain.User;
import org.apache.ibatis.annotations.Update;


/**
 * (User)表数据库访问层
 *
 * @author 都忠良
 * @since 2022-09-22 13:30:40
 */

public interface UserMapper extends BaseMapper<User> {
    @Update("update sys_user set password = #{newPassword} where userName = #{userName} ")
    void updatePassword(UserPasswordDTO userPasswordDTO);
}

