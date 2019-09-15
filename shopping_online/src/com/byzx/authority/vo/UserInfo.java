package com.byzx.authority.vo;

import java.util.Date;

public class UserInfo {
	private Integer shopId;
	
	public Integer getShopId() {
		return shopId;
	}
	public void setShopId(Integer shopId) {
		this.shopId = shopId;
	}
	//用户的id
    private Integer userId;
    //用户组id
    private Integer groupId;
    //用户昵称
    private String nickName;
    //登录时所用的账号
    private String userCode;
    //用户密码
    private String userPwd;
    //用户类型
    private String userType;
    //用户状态
    private String userState;
    //删除状态
    private String isDelete;
    //创建人
    private Integer createBy;
    //创建时间
    private Date createTime;
    //修改人
    private Integer updateBy;
    //修改时间
    private Date updateTime;
    //关联 UserGroup
    private UserGroup userGroup;
    //关联 Role
    private Role role;
    //关联 store_id
    private Integer storeId;
    public Integer getStoreId() {
		return storeId;
	}
	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}
	
	
	public UserInfo(){}
    public UserInfo(String userCode, String userType, String userState) {
		super();
		this.userCode = userCode;
		this.userType = userType;
		this.userState = userState;
	}

	public UserGroup getUserGroup() {
		return userGroup;
	}

	public void setUserGroup(UserGroup userGroup) {
		this.userGroup = userGroup;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	//get 和 set 方法
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getGroupId() {
        return groupId;
    }

    public void setGroupId(Integer groupId) {
        this.groupId = groupId;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName == null ? null : nickName.trim();
    }

    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode == null ? null : userCode.trim();
    }

    public String getUserPwd() {
        return userPwd;
    }

    public void setUserPwd(String userPwd) {
        this.userPwd = userPwd == null ? null : userPwd.trim();
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType == null ? null : userType.trim();
    }

    public String getUserState() {
        return userState;
    }

    public void setUserState(String userState) {
        this.userState = userState == null ? null : userState.trim();
    }

    public String getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(String isDelete) {
        this.isDelete = isDelete == null ? null : isDelete.trim();
    }

    public Integer getCreateBy() {
        return createBy;
    }

    public void setCreateBy(Integer createBy) {
        this.createBy = createBy;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(Integer updateBy) {
        this.updateBy = updateBy;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
	@Override
	public String toString() {
		return "UserInfo [userId=" + userId + ", groupId=" + groupId + ", nickName=" + nickName + ", userCode="
				+ userCode + ", userPwd=" + userPwd + ", userType=" + userType + ", userState=" + userState
				+ ", isDelete=" + isDelete + ", createBy=" + createBy + ", createTime=" + createTime + ", updateBy="
				+ updateBy + ", updateTime=" + updateTime + ", userGroup=" + userGroup + ", role=" + role + ", storeId="
				+ storeId + ", getStoreId()=" + getStoreId() + ", getUserGroup()=" + getUserGroup() + ", getRole()="
				+ getRole() + ", getUserId()=" + getUserId() + ", getGroupId()=" + getGroupId() + ", getNickName()="
				+ getNickName() + ", getUserCode()=" + getUserCode() + ", getUserPwd()=" + getUserPwd()
				+ ", getUserType()=" + getUserType() + ", getUserState()=" + getUserState() + ", getIsDelete()="
				+ getIsDelete() + ", getCreateBy()=" + getCreateBy() + ", getCreateTime()=" + getCreateTime()
				+ ", getUpdateBy()=" + getUpdateBy() + ", getUpdateTime()=" + getUpdateTime() + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}

	
    
    
}