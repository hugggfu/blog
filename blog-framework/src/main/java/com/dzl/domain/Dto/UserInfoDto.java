package com.dzl.domain.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserInfoDto {
    //主键@TableId
    private Long id;

    //用户名
    private String userName;
    private String password;
    //昵称
    private String nickName;
    //账号状态（0正常 1停用）
    private String status;
    private String email;
    //手机号
    private String phonenumber;
    //创建时间
    private Date createTime;

    private String token;

    private String roleName;


}
