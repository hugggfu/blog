package com.dzl.domain;

import java.util.Date;

import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
/**
 * (Link)表实体类
 *
 * @author 都忠良
 * @since 2022-11-14 13:04:27
 */
@SuppressWarnings("serial")
@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName("sys_link")
public class Link  {
    @TableId
    private Long id;


    private String blogaddress;

    private String blogname;

    private String pictureaddress;

    private Date createTime;



}

