package com.dzl.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dzl.domain.Dict;
import com.dzl.mapper.DictMapper;
import com.dzl.service.DictService;
import org.springframework.stereotype.Service;

/**
 * (Dict)表服务实现类
 *
 * @author 都忠良
 * @since 2022-09-27 22:33:48
 */
@Service("dictService")
public class DictServiceImpl extends ServiceImpl<DictMapper, Dict> implements DictService {

}

