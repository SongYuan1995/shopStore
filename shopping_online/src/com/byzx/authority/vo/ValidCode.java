package com.byzx.authority.vo;

import java.util.Date;

public class ValidCode {
    private Integer validId;

    private Integer userId;

    private Integer phone;

    private String validCode;

    private String validPast;

    private Date createTime;

    public Integer getValidId() {
        return validId;
    }

    public void setValidId(Integer validId) {
        this.validId = validId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getPhone() {
        return phone;
    }

    public void setPhone(Integer phone) {
        this.phone = phone;
    }

    public String getValidCode() {
        return validCode;
    }

    public void setValidCode(String validCode) {
        this.validCode = validCode == null ? null : validCode.trim();
    }

    public String getValidPast() {
        return validPast;
    }

    public void setValidPast(String validPast) {
        this.validPast = validPast == null ? null : validPast.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}