package com.byzx.authority.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.byzx.authority.dao.RoleMapper;
import com.byzx.authority.service.RoleService;
import com.byzx.authority.vo.Role;
import com.byzx.authority.vo.RoleAuth;
@Service
public class RoleServiceImpl implements RoleService {
	@Autowired
	private RoleMapper roleMapper;

	@Override
	public List<Role> findRoles(Map<String, Object> map) {
		return roleMapper.findRoles(map);
	}
	//判断角色名称的唯一性
	@Override
	public boolean hasRoleInfo(Map<String, Object> map) {
		List<Role> roles = roleMapper.findRoleByRoleInfo(map);
		return roles.size()==0?true:false;
	}
	//点击添加角色按钮时执行
	@Override
	public boolean insertOneRole(Map<String, Object> map) {
		Integer insertOne = roleMapper.insertOneRole(map);
		return insertOne==1?true:false;
	}
	//点击修改角色按钮时执行
	@Override
	public boolean updateOneRole(Map<String, Object> map) {
		Integer updateOne = roleMapper.updateOneRole(map);
		return updateOne==1?true:false;
	}
	//点击删除角色按钮时执行
	@Override
	public boolean deleteOneRole(Integer roleId) {
		Integer deleteOne = roleMapper.deleteOneRole(roleId);
		return deleteOne==1?true:false;
	}
	//启用/禁用
	@Override
	public boolean enableAndDisable(Role role) {
		Integer ead = roleMapper.enableAndDisable(role);
		return ead==1?true:false;
	}
	//查询当前roleId的所用的权限id;
	@Override
	public List<RoleAuth> findAllAuthbyURoleId(Integer roleId) {
		return roleMapper.findAllAuthbyURoleId(roleId);
	}
	//删除当前roleId所用的权限 insertCurrRoleAuthId
	@Override
	public void delCurrRoleAuthIds(Integer roleId) {
		roleMapper.delCurrRoleAuthIds(roleId);
	}
	//循环给当前角色添加权限id 
	@Override
	public Integer insertCurrRoleAuthId(Map<String, Object> map) {
		return roleMapper.insertCurrRoleAuthId(map);
	}
	
	

}
