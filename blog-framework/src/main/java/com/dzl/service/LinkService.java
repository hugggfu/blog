package com.dzl.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dzl.domain.Link;
import com.dzl.domain.vo.PageVo;


/**
 * (Link)表服务接口
 *
 * @author 都忠良 
 * @since 2022-11-14 13:04:28
 */
public interface LinkService extends IService<Link> {

    PageVo selectCategoryPage(Link link, Integer pageNum, Integer pageSize);
}

