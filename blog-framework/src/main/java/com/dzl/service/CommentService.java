package com.dzl.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dzl.common.ResponseResult;
import com.dzl.domain.Comment;
import org.omg.CORBA.LongHolder;

import java.util.List;


/**
 * (Comment)表服务接口
 *
 * @author 都忠良
 * @since 2022-10-25 18:06:31
 */
public interface CommentService extends IService<Comment> {

    List<Comment> findCommentDetail(Long articleId);

    ResponseResult commentList(Long articleId);
}

