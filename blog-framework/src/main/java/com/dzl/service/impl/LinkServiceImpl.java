package com.dzl.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dzl.domain.Link;
import com.dzl.domain.vo.PageVo;
import com.dzl.mapper.LinkMapper;
import com.dzl.service.LinkService;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
 * (Link)表服务实现类
 *
 * @author 都忠良
 * @since 2022-11-14 13:04:28
 */
@Service("linkService")
public class LinkServiceImpl extends ServiceImpl<LinkMapper, Link> implements LinkService {

    @Override
    public PageVo selectCategoryPage(Link link, Integer pageNum, Integer pageSize) {
        LambdaQueryWrapper<Link> lambdaQueryWrapper=new LambdaQueryWrapper<>();
        lambdaQueryWrapper.like(StringUtils.hasText(link.getBlogname()),Link::getBlogname,link.getBlogname());
        Page<Link> page=new Page<>();
        page.setCurrent(pageNum);
        page.setSize(pageSize);
        page(page,lambdaQueryWrapper);
        //封装数据返回
        PageVo pageVo = new PageVo(page.getRecords(),page.getTotal());
        return pageVo;
    }
}

