package com.dzl.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dzl.common.ResponseResult;
import com.dzl.domain.Article;
import com.dzl.domain.vo.PageVo;


/**
 * 文章表(Article)表服务接口
 *
 * @author 都忠良
 * @since 2022-10-08 19:53:44
 */
public interface ArticleService extends IService<Article> {

    PageVo selectArticlePage(Article article, Integer pageNum, Integer pageSize);

    ResponseResult add(Article article);

    Article getInfo(Long id);

    void edit(Article article);

    ResponseResult articleList(Integer pageNum, Integer pageSize, Long categoryId,String title);

    ResponseResult updateViewCount(Long id);


    ResponseResult getArticleDetail(Integer id);
}

