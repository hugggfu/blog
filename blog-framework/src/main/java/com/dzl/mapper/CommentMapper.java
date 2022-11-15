package com.dzl.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dzl.domain.Comment;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;


/**
 * (Comment)表数据库访问层
 *
 * @author 都忠良
 * @since 2022-10-25 18:06:30
 */
public interface CommentMapper extends BaseMapper<Comment> {
    @Select("select c.*,u.nick_name,u.avatar from sys_comment c left join sys_user u on c.user_id = u.id " +
            "where c.article_id = #{articleId} order by id desc")
    List<Comment> findCommentDetail(@Param("articleId") Long articleId);
}

