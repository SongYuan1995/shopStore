package com.byzx.authority.service;

import java.util.HashMap;
import java.util.List;

import com.byzx.authority.vo.AuthInfo;
import com.byzx.authority.vo.Login;
import com.byzx.authority.vo.UserInfo;

public interface LoginService {

	// 查询用户并判断
	public boolean QueryUserJudgment(Login login);

	// 获取用户
	public UserInfo getUser();

	// 查询用户拥有的权限
	public List<AuthInfo> userRight(HashMap<String, Integer> hm);
}
