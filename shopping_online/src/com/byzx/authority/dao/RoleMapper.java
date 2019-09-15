package com.byzx.authority.dao;

import java.util.List;
import java.util.Map;

import com.byzx.authority.vo.Role;
import com.byzx.authority.vo.RoleAuth;

public interface RoleMapper {
	//动态sql来查询role和user_info表
	public List<Role> findRoles(Map<String,Object> map);
	//添加角色时的唯一性验证
	public List<Role> findRoleByRoleInfo(Map<String,Object> map);
	//点击添加角色按钮时执行
	public Integer insertOneRole(Map<String,Object> map);
	//点击修改角色按钮时执行
	public Integer updateOneRole(Map<String, Object> map);
	//点击删除角色按钮时执行
	public Integer deleteOneRole(Integer roleId);
	//启用/禁用
	public Integer enableAndDisable(Role role);
	//查询当前roleId的所用的权限id
	public List<RoleAuth> findAllAuthbyURoleId(Integer roleId);
	//删除当前roleId所用的权限 insertCurrRoleAuthId
	 public void delCurrRoleAuthIds(Integer roleId);
	//循环给当前角色添加权限id 
	 public Integer insertCurrRoleAuthId(Map<String,Object> map);
	
	
}
