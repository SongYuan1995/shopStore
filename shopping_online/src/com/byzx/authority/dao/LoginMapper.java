package com.byzx.authority.dao;

import java.util.HashMap;
import java.util.List;

import com.byzx.authority.vo.AuthInfo;
import com.byzx.authority.vo.Login;
import com.byzx.authority.vo.UserInfo;

public interface LoginMapper {

	//查询用户
	public UserInfo QueryUserJudgment(Login login) ;
	//查询用户拥有的权限
	public List<AuthInfo> userRight(HashMap<String,Integer> hm);
}
