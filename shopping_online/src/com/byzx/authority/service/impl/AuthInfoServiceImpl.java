package com.byzx.authority.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.byzx.authority.dao.AuthInfoMapper;
import com.byzx.authority.service.AuthInfoService;
import com.byzx.authority.vo.AuthInfo;
import com.byzx.authority.vo.Role;
import com.byzx.authority.vo.UserInfo;

@Service
public class AuthInfoServiceImpl implements AuthInfoService {
@Autowired
	private AuthInfoMapper authInfoMapper;
	//查询权限
	@Override
	public List<AuthInfo> findAuthority(Map<String, Object> map) {
		return authInfoMapper.findAuthority(map);
	}
	//查询user在list页面上展示
	@Override
	public List<UserInfo> findAllUserInfo(Map<String,Object> map) {
		return authInfoMapper.findAllUserInfo(map);
	}
	//全查role表
	@Override
	public List<Role> findAllRole() {
		return authInfoMapper.findAllRole();
	}
	//根据角色名称查角色id
	@Override
	public Role findIdByRoleName(String roleName) {
		return authInfoMapper.findIdByRoleName(roleName);
	}
/* 权限的管理，添加权限时,判断权限名是否重复  */
	@Override
	public boolean isExistInputAuth(String authName,Integer parentId) {
		boolean authNameisExist=true;
		String authNames = authInfoMapper.findAuthNamesByPid(parentId);
		//切割字符串
		System.out.println("当前的权限名称为"+authNames);
		if(null!=authNames) {
		String[] curruAthNames = authNames.split(",");
		for(String curruAthName:curruAthNames) {
			System.err.println("切割字符串，权限名称："+curruAthName);
			//判断切割后的字符串是否等于输入的字符串
			if(curruAthName.equals(authName)) {
				System.out.println("传过来的值为："+authName);
				authNameisExist=false;
				}
			}
		}else {
			authNameisExist=true;
		}
		//System.out.println("boolean值到底为啥？？？"+authNameisExist);
		return authNameisExist;
	}
	//判断URL是否存在
	@Override
	public boolean isExistAuthURL(String userUrl) {
		boolean authURLisExist=true;
		List<AuthInfo> authInfo = authInfoMapper.findAuthByURL(userUrl);
		authURLisExist =authInfo.size()==0?true:false;
		return authURLisExist;
	}
	
	//判断code是否存在
	@Override
	public boolean isExistAuthCode(String userCode) {
		boolean authCodeisExist=true;
		List<AuthInfo> authInfo1 = authInfoMapper.findAuthByCode(userCode);
		authCodeisExist =authInfo1.size()==0?true:false;
		return authCodeisExist;
	}
	//添加权限时
	@Override
	public void insertSelectiveAuth(AuthInfo authInfo) {
		authInfoMapper.insertSelectiveAuth(authInfo);
	}
	//修改权限时的回显，通过id查询authinfo
	@Override
	public AuthInfo finndAuthInfoById(Integer authId) {
		return authInfoMapper.finndAuthInfoById(authId);
	}
	//修改权限时点击了添加按钮后
	@Override
	public void updateThisAuth(AuthInfo authInfo) {
		authInfoMapper.updateThisAuth(authInfo);
	}
	@Override
	public void deleteThisAuth(AuthInfo authInfo) {
		authInfoMapper.deleteThisAuth(authInfo);
	}
	
	@Override
	public boolean regainThisAuth(AuthInfo authInfo) {
		int regainThisAuth = authInfoMapper.regainThisAuth(authInfo);
		return regainThisAuth!=1?true:false;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
