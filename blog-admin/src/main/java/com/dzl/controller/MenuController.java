package com.dzl.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dzl.common.Constants;
import com.dzl.common.ResponseResult;
import com.dzl.common.Result;
import com.dzl.domain.Dict;
import com.dzl.domain.Menu;
import com.dzl.mapper.DictMapper;
import com.dzl.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController

@RequestMapping("/menu")
public class MenuController {
    @Autowired
    private MenuService menuService;
    @Autowired
    private DictMapper dictMapper;
    @PostMapping
    @PreAuthorize("hasAuthority('sys:menu:save')")
    public ResponseResult save(@RequestBody Menu menu) {
        menuService.saveOrUpdate(menu);
        return ResponseResult.okResult();
    }

    @GetMapping("/list")
    public ResponseResult list(@RequestParam(defaultValue = "") String name){
        return ResponseResult.okResult(menuService.findMenus(name));
    }
    @DeleteMapping("/{id}")
    @PreAuthorize("hasAuthority('sys:menu:delete')")

    public ResponseResult delete(@PathVariable Integer id) {
        menuService.removeById(id);
        return ResponseResult.okResult();
    }
    @PostMapping("/del/batch")
    @PreAuthorize("hasAuthority('sys:menu:delete')")
    public ResponseResult deleteBatch(@RequestBody List<Integer> ids) {
        menuService.removeByIds(ids);
        return ResponseResult.okResult();
    }
    @GetMapping("/icons")
    @PreAuthorize("hasAuthority('sys:menu:list')")
    public Result getIcons() {
        QueryWrapper<Dict> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("type", Constants.DICT_TYPE_ICON);
        return Result.success(dictMapper.selectList(queryWrapper) );
    }

}
