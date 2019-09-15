package com.byzx.authority.service;

import java.util.List;
import java.util.Map;

import com.byzx.authority.vo.AuthInfo;
import com.byzx.authority.vo.Role;
import com.byzx.authority.vo.UserInfo;

public interface AuthInfoService {
	//查询权限
	public List<AuthInfo> findAuthority(Map<String,Object> map);
	//查询user在list页面上展示
	public List<UserInfo> findAllUserInfo(Map<String,Object> map);
	//角色表全查
	public List<Role> findAllRole();
	//根据角色名称查角色id
	public Role findIdByRoleName(String roleName);
	
	
	//权限的管理，添加权限时,判断权限名是否重复
	public boolean isExistInputAuth(String authName,Integer parentId);
	//添加权限时
	public void insertSelectiveAuth(AuthInfo authInfo);
	//用Code查auth_info表
	public boolean isExistAuthCode(String userCode);
	//用url查auth_info表
	public boolean isExistAuthURL(String userUrl);
	//修改权限时的回显，通过id查询authinfo
	public AuthInfo finndAuthInfoById(Integer authId);
	//修改权限时点击了添加按钮后
	public void updateThisAuth(AuthInfo authInfo);
	//删除权限，将权限的state变为0，禁用
	public void deleteThisAuth(AuthInfo authInfo);
	//恢复权限，将权限的state变为1，启用
	public boolean regainThisAuth(AuthInfo authInfo);

}
