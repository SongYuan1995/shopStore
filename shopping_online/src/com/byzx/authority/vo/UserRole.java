package com.byzx.authority.vo;

import java.io.Serializable;

/**
 * 
 * @author Administrator
 * @date 2019年8月16日
 * @param
 */
public class UserRole implements Serializable {
	private static final long serialVersionUID = 2467348565575845680L;
	// 用户角色id
	private Integer userRoleId;
	// 角色id
	private Integer roleId;
	// 用户id
	private Integer userId;

	public UserRole() {
	}

	public UserRole(Integer userRoleId, Integer roleId, Integer userId) {
		this.userRoleId = userRoleId;
		this.roleId = roleId;
		this.userId = userId;
	}

	public Integer getUserRoleId() {
		return userRoleId;
	}

	public void setUserRoleId(Integer userRoleId) {
		this.userRoleId = userRoleId;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "UserRole [userRoleId=" + userRoleId + ", roleId=" + roleId + ", userId=" + userId + "]";
	}

}