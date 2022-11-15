package com.dzl.domain;


import java.io.Serializable;
import java.util.List;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
/**
 * (Comment)表实体类
 *
 * @author 都忠良
 * @since 2022-10-25 18:06:31
 */
@SuppressWarnings("serial")
@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName("sys_comment")
public class Comment  {
    @TableId
    private Long id;

    //内容
    private String content;
    //评论人
    private Long userId;
    //评论时间
    private String time;
    //父id
    private Long pid;
    //最上级评论id
    private Long originId;
    //关联文章的id
    private Long articleId;
    @TableField(exist = false)
    private String nickname;
    @TableField(exist = false)
    private String avatar;
    @TableField(exist = false)
    private String pNickname;  // 父节点的用户昵称
    @TableField(exist = false)
    private Long pUserId;  // 父节点的用户id

    @TableField(exist = false)
    private List<Comment> children;


}

