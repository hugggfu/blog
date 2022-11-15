package com.dzl.domain;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.baomidou.mybatisplus.annotation.TableName;

/**
 * 用户和角色关联表(UserRole)表实体类
 *
 * @author 都忠良
 * @since 2022-10-25 12:15:22
 */
@SuppressWarnings("serial")
@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName("sys_user_role")
public class UserRole  {
    //用户ID@TableId
    private Long userId;
    //角色ID@TableId
    private Long roleId;




}

