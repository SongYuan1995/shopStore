package com.byzx.authority.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.byzx.authority.dao.UserInfoMapper;
import com.byzx.authority.service.UserInfoService;
import com.byzx.authority.vo.AuthInfo;
import com.byzx.authority.vo.ParameterTypeQuery;
import com.byzx.authority.vo.Role;
import com.byzx.authority.vo.UserAuth;
import com.byzx.authority.vo.UserGroup;
import com.byzx.authority.vo.UserInfo;
import com.byzx.authority.vo.UserRole;

@Service
public class UserInfoServiceImpl implements UserInfoService {
	@Autowired
	private UserInfoMapper userInfoMapper;
	//根据用户的userCode查询用户
	@Override
	public UserInfo findUserByCodeAndPwd(ParameterTypeQuery ptq) {
		return userInfoMapper.findUserByCodeAndPwd(ptq);
	}
	//判断是否为正确的用户名和用户密码
	@Override
	public boolean isRightUser(ParameterTypeQuery ptq) {
		return null!=userInfoMapper.findUserByCodeAndPwd(ptq)?true:false;
	}
	
	@Override
	public UserInfo findUserInfoByCodeAndPwd(UserInfo userInfo) {
		return userInfoMapper.findUserInfoByCodeAndPwd(userInfo);
	}
	@Override
	public boolean isRightUserInfo(UserInfo userInfo) {
		if(null==userInfoMapper.findUserInfoByCodeAndPwd(userInfo)) {
			return false;
		}else {
			return true;
		}
	}
	//模糊查询
	@Override
	public List<UserInfo> findUserFuzzy(ParameterTypeQuery ptq) {
		return userInfoMapper.findUserFuzzy(ptq) ;
	}
	//判断有没有该用户名，用户名的唯一效验
	@Override
	public boolean hasOrNotUserCode(ParameterTypeQuery ptq) {
		return null==userInfoMapper.findUserByCodeAndPwd(ptq)?true:false;
	}
	//添加一条用户信息
	@Override
	public void addUserInfo(UserInfo userInfo) {
		userInfoMapper.addUserInfo(userInfo);
	}
	//<!-- 全查user_group表 -->
	@Override
	public List<UserGroup> findAllUserGroup() {
		return userInfoMapper.findAllUserGroup();
	}
	//<!-- 根据用户组名查询用户组对应的id -->
	@Override
	public UserGroup findUserGroupByName(String groupName) {
		return userInfoMapper.findUserGroupByName(groupName);
	}
	//<!-- 根据用户组Id查询用户组对应的名字 -->
	@Override
	public UserGroup findUserGroupById(Integer groupId) {
		return userInfoMapper.findUserGroupById(groupId);
	}
	//动态sql去update表user_info,传经来一个hashMap;
	@Override
	public void updateByPrimaryKeyUserInfo(Map<String, Object> map) {
		userInfoMapper.updateByPrimaryKeyUserInfo(map);
		
	}
	//全查user_info表
	@Override
	public List<UserInfo> findAllUserInfo(Map<String, Object> map) {
		return userInfoMapper.findAllUserInfo(map);
	}
	//查询当前用户角色id，返回一个字符串
	@Override
	public String findAllRoleIdString(Integer userId) {
		return userInfoMapper.findAllRoleIdString(userId);
	}
	//全查role表，展示在用户分配角色的框里
	@Override
	public List<Role> findAssignAllRoles() {
		return userInfoMapper.findAssignAllRoles();
	}
	//<!-- 删除该用户对应的所有用户角色 -->
	@Override
	public void deleteThisUserRoles(Integer userId) {
		userInfoMapper.deleteThisUserRoles(userId);
	}
	//添加一个当前用户一个角色
	@Override
	public void reAssignRoles(UserRole userRole){
		userInfoMapper.reAssignRoles(userRole);
	}
 	//全查autn_info表
	@Override
	public List<AuthInfo> findAllAuthInfo() {
		return userInfoMapper.findAllAuthInfo();
	}
	//根据当前用户的userId查询，该用户对于的所有的权限Id
	@Override
	public List<UserAuth> findAllAuthIDbyUserId(Integer userId) {
		return userInfoMapper.findAllAuthIDbyUserId(userId);
	}
  	//删除id为userId的当前用户的所有
	@Override
	public void delCurrUserAuthIds(Integer userId) {
		userInfoMapper.delCurrUserAuthIds(userId);
	}
	//循环给当前用户添加权限id 
	@Override
	public Integer insertCurrUserAuthId(Map<String, Object> map) {
		return userInfoMapper.insertCurrUserAuthId(map);
	}
	
	
	

	
	
}
