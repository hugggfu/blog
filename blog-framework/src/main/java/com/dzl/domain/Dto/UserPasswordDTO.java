package com.dzl.domain.Dto;

import lombok.Data;

@Data
public class UserPasswordDTO {
    private Long id;
    private String userName;
    private String password;
    private String newPassword;
}
