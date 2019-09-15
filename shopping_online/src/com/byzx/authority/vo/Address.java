package com.byzx.authority.vo;

public class Address {
	//主键
    private Integer addrId;
    //地址信息
    private String addrInfo;
    //邮政地址
    private String postCode;
    //收货人
    private String reapPerson;
    //手机
    private String phone;
    //用户Id
    private Integer userId;
    //是否默认
    private String isDefault;

    public Integer getAddrId() {
        return addrId;
    }

    public void setAddrId(Integer addrId) {
        this.addrId = addrId;
    }

    public String getAddrInfo() {
        return addrInfo;
    }

    public void setAddrInfo(String addrInfo) {
        this.addrInfo = addrInfo == null ? null : addrInfo.trim();
    }

    public String getPostCode() {
        return postCode;
    }

    public void setPostCode(String postCode) {
        this.postCode = postCode == null ? null : postCode.trim();
    }

    public String getReapPerson() {
        return reapPerson;
    }

    public void setReapPerson(String reapPerson) {
        this.reapPerson = reapPerson == null ? null : reapPerson.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getIsDefault() {
        return isDefault;
    }

    public void setIsDefault(String isDefault) {
        this.isDefault = isDefault == null ? null : isDefault.trim();
    }
}