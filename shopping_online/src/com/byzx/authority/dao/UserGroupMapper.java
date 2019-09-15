package com.byzx.authority.dao;

import java.util.List;
import java.util.Map;

import com.byzx.authority.vo.GroupRole;
import com.byzx.authority.vo.UserGroup;

public interface UserGroupMapper {
	//列表展示页面和模糊查询共用的查询user_group表
	public List<UserGroup> findGroupFuzzy(Map<String,Object> map);
	//验证用户组名和用户组Code，用户组名称GroupName和groupCode是否唯一
	public List<UserGroup> findGroupByGroupInfo(Map<String,Object> map);
	//向user_group添加一条数据 -->
	public Integer insertOneGroup(Map<String,Object> map);
	//点击修改角色按钮
	public Integer updateOneGroup(Map<String,Object> map);
	//删除用户组
	public Integer deleteUserGroup(UserGroup userGroup);
	//启用/禁用用户组
	public Integer enAndDisGroup(UserGroup userGroup);
	//查询当前的用户组所对应的角色 
	public String findAllRoleIdString(Integer groupId);
	//根据groupId删除当前用户组的所有角色 
	public Integer deleteThisGroupRoles(Integer groupId);
	//根据groupId循环添加为该用户组分配的角色
	public Integer insertRolesForGroup(GroupRole groupRole);
	
	
	
	

}
