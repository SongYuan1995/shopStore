package com.byzx.authority.vo;

public class UserGroup {
    private Integer groupId;

    private String groupName;

    private String groupCode;

    private String groupDesc;

    private String groupState;
    
    private String createBy;
    
    private String isDelete;
    
    private UserInfo userInfo;

    
    
    public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public String getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}

	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public Integer getGroupId() {
        return groupId;
    }

    public void setGroupId(Integer groupId) {
        this.groupId = groupId;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName == null ? null : groupName.trim();
    }

    public String getGroupCode() {
        return groupCode;
    }

    public void setGroupCode(String groupCode) {
        this.groupCode = groupCode == null ? null : groupCode.trim();
    }

    public String getGroupDesc() {
        return groupDesc;
    }

    public void setGroupDesc(String groupDesc) {
        this.groupDesc = groupDesc == null ? null : groupDesc.trim();
    }

    public String getGroupState() {
        return groupState;
    }

    public void setGroupState(String groupState) {
        this.groupState = groupState == null ? null : groupState.trim();
    }

	@Override
	public String toString() {
		return "UserGroup [groupId=" + groupId + ", groupName=" + groupName + ", groupCode=" + groupCode
				+ ", groupDesc=" + groupDesc + ", groupState=" + groupState + ", createBy=" + createBy + ", isDelete="
				+ isDelete + ", userInfo=" + userInfo + "]";
	}

	
}