package com.byzx.authority.vo;

import java.io.Serializable;
import java.util.Date;

/**
 * 
 * @author Administrator
 * @date 2019年8月16日
 * @param
 */
public class ShopStore implements Serializable {
	private static final long serialVersionUID = -2388719184254682424L;
	// 店铺id
	private Integer storeId;
	// 店铺名称
	private String storeName;
	// 店铺等级
	private Integer storeLevel;
	// 店主
	private String storeHost;
	// 联系电话
	private String storePhone;
	// 关注度
	private Integer storeAgree;
	// 店铺状态
	private String storeState;
	// 创建时间
	private Date createTime;
	// 店铺介绍
	private String storeIntro;

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName == null ? null : storeName.trim();
	}

	public Integer getStoreLevel() {
		return storeLevel;
	}

	public void setStoreLevel(Integer storeLevel) {
		this.storeLevel = storeLevel;
	}

	public String getStoreHost() {
		return storeHost;
	}

	public void setStoreHost(String storeHost) {
		this.storeHost = storeHost == null ? null : storeHost.trim();
	}

	public String getStorePhone() {
		return storePhone;
	}

	public void setStorePhone(String storePhone) {
		this.storePhone = storePhone == null ? null : storePhone.trim();
	}

	public Integer getStoreAgree() {
		return storeAgree;
	}

	public void setStoreAgree(Integer storeAgree) {
		this.storeAgree = storeAgree;
	}

	public String getStoreState() {
		return storeState;
	}

	public void setStoreState(String storeState) {
		this.storeState = storeState == null ? null : storeState.trim();
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getStoreIntro() {
		return storeIntro;
	}

	public void setStoreIntro(String storeIntro) {
		this.storeIntro = storeIntro == null ? null : storeIntro.trim();
	}

	@Override
	public String toString() {
		return "ShopStore [storeId=" + storeId + ", storeName=" + storeName + ", storeLevel=" + storeLevel
				+ ", storeHost=" + storeHost + ", storePhone=" + storePhone + ", storeAgree=" + storeAgree
				+ ", storeState=" + storeState + ", createTime=" + createTime + ", storeIntro=" + storeIntro + "]";
	}

}