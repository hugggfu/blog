package com.dzl.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dzl.domain.Category;
import com.dzl.domain.Comment;
import com.dzl.domain.vo.CategoryVo;
import com.dzl.domain.vo.PageVo;

import java.util.List;


/**
 * 分类表(Category)表服务接口
 *
 * @author 都忠良
 * @since 2022-10-08 19:54:17
 */
public interface CategoryService extends IService<Category> {

    PageVo selectCategoryPage(Category category, Integer pageNum, Integer pageSize);

    List<CategoryVo> listAllCategory();

    List<CategoryVo> getCategoryList();

}

