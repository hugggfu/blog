package com.dzl.controller;

import com.dzl.common.ResponseResult;
import com.dzl.domain.Article;
import com.dzl.domain.vo.PageVo;
import com.dzl.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/article")
public class ArticleController {
    @Autowired
    private ArticleService articleService;

    @GetMapping("/list")
    public ResponseResult list(Article article, Integer pageNum, Integer pageSize)
    {
        PageVo pageVo = articleService.selectArticlePage(article,pageNum,pageSize);
        return ResponseResult.okResult(pageVo);
    }
    @DeleteMapping("/{id}")
    public ResponseResult delete(@PathVariable Integer id) {
        articleService.removeById(id);
        return ResponseResult.okResult();
    }
    @PostMapping
    public ResponseResult add(@RequestBody Article article){
        return articleService.add(article);
    }
    @GetMapping(value = "/{id}")
    public ResponseResult getInfo(@PathVariable(value = "id")Long id){
        Article article = articleService.getInfo(id);
        return ResponseResult.okResult(article);
    }
    @PutMapping
    public ResponseResult edit(@RequestBody Article article){
        articleService.edit(article);
        return ResponseResult.okResult();
    }


}
