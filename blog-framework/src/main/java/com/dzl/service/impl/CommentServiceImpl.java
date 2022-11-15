package com.dzl.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dzl.common.ResponseResult;
import com.dzl.domain.Comment;
import com.dzl.domain.User;
import com.dzl.mapper.CommentMapper;
import com.dzl.service.CommentService;
import com.dzl.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * (Comment)表服务实现类
 *
 * @author 都忠良
 * @since 2022-10-25 18:06:32
 */
@Service("commentService")
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements CommentService {
    @Autowired
    private UserService userService;
    @Autowired
    private CommentService commentService;
    @Resource
    private CommentMapper commentMapper;
    @Override
    public List<Comment> findCommentDetail(Long articleId) {
        return commentMapper.findCommentDetail(articleId);
    }

    @Override
    public ResponseResult commentList(Long articleId) {
        //查询对应文章的根评论
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Comment::getArticleId,articleId);
        queryWrapper.eq(Comment::getOriginId,-1);
        List<Comment> list = list(queryWrapper);

        List<Comment> comments=toCommentList(list);
        for (Comment comment : comments) {
            //查询对应的子评论
            List<Comment> children = getChildren(comment.getId());
            comment.setChildren(children);

        }
          return ResponseResult.okResult(comments);

    }

    private List<Comment> getChildren(Long id) {
        LambdaQueryWrapper<Comment> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Comment::getOriginId,id);
        queryWrapper.orderByDesc(Comment::getTime);
        List<Comment> comments = list(queryWrapper);
        List<Comment> toCommentList = toCommentList(comments);

        return toCommentList;
    }

    private List<Comment> toCommentList(List<Comment> list) {
        //遍历list集合
        for (Comment comment : list) {
            //通过UserId查询评论用户的昵称并赋值
            String nickName = userService.getById(comment.getUserId()).getNickName();
            String avatar = userService.getById(comment.getUserId()).getAvatar();
            comment.setNickname(nickName);
            comment.setAvatar(avatar);
            //通过Pid查询父用户的昵称并赋值
            //如果Pid不为-1才进行查询
            if(comment.getPid()!=-1){
                Comment comment1 = commentService.getById(comment.getPid());
                String pNickName = userService.getById(comment1.getUserId()).getNickName();
                String pAvatar = userService.getById(comment1.getUserId()).getAvatar();
                comment.setPNickname(pNickName);
                comment.setAvatar(pAvatar);
            }
        }
           return list;

    }
}

