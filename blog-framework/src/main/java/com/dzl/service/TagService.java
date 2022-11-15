package com.dzl.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.dzl.common.ResponseResult;
import com.dzl.domain.Tag;
import com.dzl.domain.vo.PageVo;
import com.dzl.domain.vo.TagVo;

import java.util.List;


/**
 * 标签(Tag)表服务接口
 *
 * @author 都忠良
 * @since 2022-10-10 22:36:47
 */
public interface TagService extends IService<Tag> {

    ResponseResult<PageVo> pageTagList(Integer pageNum, Integer pageSize, Tag tag);

    List<TagVo> listAllTag();
}

