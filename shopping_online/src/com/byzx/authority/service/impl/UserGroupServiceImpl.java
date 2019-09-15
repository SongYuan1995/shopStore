package com.byzx.authority.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.byzx.authority.dao.UserGroupMapper;
import com.byzx.authority.service.UserGroupService;
import com.byzx.authority.vo.GroupRole;
import com.byzx.authority.vo.UserGroup;
@Service
public class UserGroupServiceImpl implements UserGroupService {
	@Autowired
	private UserGroupMapper userGroupMapper;
	//列表展示页面和模糊查询共用的查询user_group表
	@Override
	public List<UserGroup> findGroupFuzzy(Map<String, Object> map) {
		return userGroupMapper.findGroupFuzzy(map);
	}
	//验证用户组名和用户组Code，用户组名称GroupName和groupCode是否唯一
	@Override
	public boolean isExistGroupInfo(Map<String, Object> map) {
		return userGroupMapper.findGroupByGroupInfo(map).size()>0?false:true;
	}
	//向user_group添加一条数据 
	@Override
	public boolean insertOneGroup(Map<String, Object> map) {
		Integer oneGroup = userGroupMapper.insertOneGroup(map);
		return oneGroup==1?true:false;
	}
	//修改用户组
	@Override
	public boolean updateOneGroup(Map<String, Object> map) {
		Integer oneGroup = userGroupMapper.updateOneGroup(map);
		return oneGroup==1?true:false;
	}
	//删除用户组
	@Override
	public boolean deleteUserGroup(UserGroup userGroup) {
		Integer delOneGroup = userGroupMapper.deleteUserGroup(userGroup);
		return delOneGroup==1?true:false;		
	}
	//启用/禁用用户组
	@Override
	public boolean enAndDisGroup(UserGroup userGroup) {
		Integer eadOneGroup = userGroupMapper.enAndDisGroup(userGroup);
		return eadOneGroup==1?true:false;	
	}
	//查询当前的用户组所对应的角色 
	@Override
	public String findAllRoleIdString(Integer groupId) {
		return userGroupMapper.findAllRoleIdString(groupId);
	}
	//根据groupId删除当前用户组的所有角色 
	@Override
	public Integer deleteThisGroupRoles(Integer groupId) {
		return userGroupMapper.deleteThisGroupRoles(groupId);
	}
	//根据groupId循环添加为该用户组分配的角色
	@Override
	public Integer insertRolesForGroup(GroupRole groupRole) {
		return userGroupMapper.insertRolesForGroup(groupRole);
	}
	
	

}
