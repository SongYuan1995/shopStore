package com.byzx.authority.service;

import java.util.List;
import java.util.Map;

import com.byzx.authority.vo.MemberInfo;

public interface UserService {
	public List<MemberInfo> findUserInfoU(Map<String,Object>map);
	
	public void updateUserState1(MemberInfo memberInfo);
	
	public void updateUserPwds(Integer userId);
	
}
