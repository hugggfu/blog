package com.dzl.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dzl.domain.UserRole;
import com.dzl.mapper.UserRoleMapper;
import com.dzl.service.UserRoleService;
import org.springframework.stereotype.Service;

/**
 * (UserRole)表服务实现类
 *
 * @author 都忠良
 * @since 2022-09-22 13:35:57
 */
@Service("userRoleService")
public class UserRoleServiceImpl extends ServiceImpl<UserRoleMapper, UserRole> implements UserRoleService {

}

