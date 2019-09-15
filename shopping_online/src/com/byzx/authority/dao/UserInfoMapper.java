package com.byzx.authority.dao;

import java.util.List;
import java.util.Map;

import com.byzx.authority.vo.AuthInfo;
import com.byzx.authority.vo.ParameterTypeQuery;
import com.byzx.authority.vo.Role;
import com.byzx.authority.vo.UserAuth;
import com.byzx.authority.vo.UserGroup;
import com.byzx.authority.vo.UserInfo;
import com.byzx.authority.vo.UserRole;

public interface UserInfoMapper {
	//用动态aql用户名user_code和密码user_pwd来查询user_info表 
	public UserInfo findUserByCodeAndPwd(ParameterTypeQuery ptq);
	//用用户名user_code和密码user_pwd来查询user_info表 
	public UserInfo  findUserInfoByCodeAndPwd(UserInfo userInfo);
	//模糊查询
	public List<UserInfo> findUserFuzzy(ParameterTypeQuery ptq);
	//添加一条用户信息
	public void addUserInfo(UserInfo userInfo);
	//<!-- 全查user_group表 -->
	public List<UserGroup> findAllUserGroup();
	//<!-- 根据用户组名查询用户组对应的id -->
	public UserGroup findUserGroupByName(String groupName);
	//<!-- 根据用户组Id查询用户组对应的名字 -->
	public UserGroup findUserGroupById(Integer groupId);
	//动态sql去update表user_info,传经来一个hashMap;
	public void updateByPrimaryKeyUserInfo(Map<String,Object> map);
	//全查user_info表
	public List<UserInfo> findAllUserInfo(Map<String,Object> map);
	//查询当前用户角色id，返回一个字符串
	public String findAllRoleIdString(Integer userId);
	//全查role表
	public List<Role> findAssignAllRoles();
	//<!-- 删除该用户对应的用户角色 -->
  	public void deleteThisUserRoles(Integer userId);
  	//添加一个当前用户一个角色
  	public void reAssignRoles(UserRole userRole);
  	//全查autn_info表
  	public List<AuthInfo> findAllAuthInfo();
  	//根据当前用户的userId查询，该用户对于的所有的权限Id
  	public List<UserAuth> findAllAuthIDbyUserId(Integer userId);
  	//删除id为userId的当前用户的所有
  	public void delCurrUserAuthIds(Integer userId);
  	//循环给当前用户添加权限id 
  	public Integer insertCurrUserAuthId(Map<String,Object> map);
  	
  	
  	
  	
  	
  	
  	
} 
