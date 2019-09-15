package com.byzx.authority.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.byzx.authority.dao.UserMapper;
import com.byzx.authority.service.UserService;
import com.byzx.authority.vo.MemberInfo;

@Service
public class UserMapperLmp implements UserService {
	@Autowired
	private UserMapper userMapper;

	@Override
	public List<MemberInfo> findUserInfoU(Map<String, Object> map) {
		
		return userMapper.findUserInfoU(map);
	}

	@Override
	public void updateUserState1(MemberInfo memberInfo) {
		userMapper.updateUserState1(memberInfo);
		
	}

	@Override
	public void updateUserPwds(Integer userId) {
		userMapper.updateUserPwds(userId);
		
	}
	
	
}
