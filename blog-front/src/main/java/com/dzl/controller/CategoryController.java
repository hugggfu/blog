package com.dzl.controller;

import com.dzl.common.ResponseResult;
import com.dzl.domain.Category;
import com.dzl.domain.vo.CategoryVo;
import com.dzl.domain.vo.PageVo;
import com.dzl.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/front/category")
public class CategoryController {
    @Autowired
    private CategoryService categoryService;

    @GetMapping("/listAllCategory")
    public ResponseResult listAllCategory(){
        List<CategoryVo> list = categoryService. getCategoryList();
        return ResponseResult.okResult(list);
    }

}
