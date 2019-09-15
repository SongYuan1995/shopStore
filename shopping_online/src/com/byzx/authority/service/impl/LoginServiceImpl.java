package com.byzx.authority.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.byzx.authority.dao.LoginMapper;
import com.byzx.authority.service.LoginService;
import com.byzx.authority.vo.AuthInfo;
import com.byzx.authority.vo.Login;
import com.byzx.authority.vo.UserInfo;

/**
 * 
 * @author Administrator
 * @date 2019年8月16日
 * @param
 */
@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	public LoginMapper loginMapper;
	// 用户信息
	UserInfo userInfo;

	// 查询用户并判断
	@Override
	public boolean QueryUserJudgment(Login login) {
		UserInfo userInfo = loginMapper.QueryUserJudgment(login);
		if (null == userInfo) {// || userInfo.getUserPwd().equals(login.getUserPwd())
			return true;
		}
		this.userInfo = userInfo;
		return false;
	}

	// 获取用户
	@Override
	public UserInfo getUser() {
		return userInfo;
	}

	// 用户权限信息
	@Override
	public List<AuthInfo> userRight(HashMap<String, Integer> hm) {
		List<AuthInfo> list = loginMapper.userRight(hm);
		return list;
	}

}
