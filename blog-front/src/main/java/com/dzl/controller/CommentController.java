package com.dzl.controller;

import cn.hutool.core.date.DateUtil;
import com.alibaba.fastjson.JSON;
import com.dzl.common.AppHttpCodeEnum;
import com.dzl.common.ResponseResult;
import com.dzl.domain.Comment;
import com.dzl.domain.LoginUser;
import com.dzl.exception.SystemException;
import com.dzl.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
@RestController
@RequestMapping("/front/comment")
public class CommentController {
    @Autowired
    private AuthenticationManager authenticationManager;
    @Resource
    private CommentService commentService;

    // 新增或者更新
    @PostMapping
    public ResponseResult save(@RequestBody Comment comment) {
        if(!StringUtils.hasText(comment.getContent())){
            throw new SystemException(AppHttpCodeEnum.REQUIRE_CONTENT);
        }
        if (comment.getId() == null) { // 新增评论
            //获取token 解析获取userid
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            LoginUser loginUser = (LoginUser) authentication.getPrincipal();
            //获取userid
            Long userId = loginUser.getUser().getId();
            comment.setUserId(userId);
            comment.setTime(DateUtil.now());

            if (comment.getPid() != null) {  // 判断如果是回复，进行处理
                Long pid = comment.getPid();
                Comment pComment = commentService.getById(pid);
                if (pComment.getOriginId() != -1) {  // 如果当前回复的父级有祖宗，那么就设置相同的祖宗
                    comment.setOriginId(pComment.getOriginId());
                } else {  // 否则就设置父级为当前回复的祖宗
                    comment.setOriginId(comment.getPid());
                }
            }


        }
        commentService.saveOrUpdate(comment);
        return ResponseResult.okResult();
    }

    @GetMapping("/tree/{articleId}")
    public ResponseResult commentList(@PathVariable Long articleId) {

        return commentService.commentList(articleId);
    }
    @DeleteMapping("/{id}")
    public ResponseResult delete(@PathVariable Integer id) {
        commentService.removeById(id);
        return ResponseResult.okResult();
    }
}
