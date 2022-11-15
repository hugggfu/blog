package com.dzl.controller;

import com.dzl.common.ResponseResult;
import com.dzl.domain.Role;
import com.dzl.domain.vo.PageVo;
import com.dzl.service.RoleService;
import com.dzl.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController

@RequestMapping("/role")
public class RoleController {
    @Autowired
    private RoleService roleService;

    @GetMapping("/listAll")
    @PreAuthorize("hasAuthority('sys:role:list')")
    public  ResponseResult listAll(){
        List<Role> roles = roleService.selectRoleAll();
        return ResponseResult.okResult(roles) ;
    }

    @GetMapping("/list")
    @PreAuthorize("hasAuthority('sys:role:list')")
    public ResponseResult<PageVo> list( Integer pageNum,  Integer pageSize, Role role){
        return roleService.listAll(pageNum,pageSize,role);
    }
    @PostMapping("")
    @PreAuthorize("hasAuthority('sys:role:save')")
    public ResponseResult add(@RequestBody Role role){

        return roleService.addUser(role);
    }
    @PutMapping
    @PreAuthorize("hasAuthority('sys:role:edit')")
    public ResponseResult edit(@RequestBody Role role) {
        roleService.updateUser(role);
        return ResponseResult.okResult();
    }
    @DeleteMapping("/{id}")
    @PreAuthorize("hasAuthority('sys:role:delete')")
    public ResponseResult delete(@PathVariable Integer id) {
        roleService.removeById(id);
        return ResponseResult.okResult();
    }


    @PostMapping("/{userIds}")
    public ResponseResult remove(@PathVariable List<Long> userIds) {
        if(userIds.contains(SecurityUtils.getUserId())){
            return ResponseResult.errorResult(500,"不能删除当前你正在使用的用户");
        }
        roleService.removeByIds(userIds);
        return ResponseResult.okResult();
    }
    /**
     * 绑定角色和菜单的关系
     * @param roleId 角色id
     * @param menuIds 菜单id数组
     * @return
     */
    @PostMapping("/roleMenu/{roleId}")
    @PreAuthorize("hasAuthority('sys:role:list')")
    public ResponseResult RoleMenu(@PathVariable Long roleId, @RequestBody List<Long> menuIds) {
        roleService.setRoleMenu(roleId, menuIds);
        return ResponseResult.okResult();
    }
    @GetMapping("/roleMenu/{roleId}")
    @PreAuthorize("hasAuthority('sys:role:list')")
    public ResponseResult getRoleMenu(@PathVariable Integer roleId) {
        return ResponseResult.okResult(roleService.getRoleMenu(roleId));
    }
}
