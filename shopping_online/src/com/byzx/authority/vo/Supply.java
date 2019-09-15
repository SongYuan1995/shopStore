package com.byzx.authority.vo;

import java.io.Serializable;

/**
 * 
 * @author Administrator
 * @date 2019年8月16日
 * @param
 */
public class Supply implements Serializable {

	private static final long serialVersionUID = -1581364506272715694L;

	private Integer supplyId;
	// 供货商编号
	private String supplyNum;
	// 供货商名称
	private String supplyName;
	// 供货商介绍
	private String supplyIntroduce;
	// 联系人
	private String concat;
	// 联系电话
	private String phone;
	// 地址
	private String address;
	// 供货商状态 0是未删除，1是已删除
	private String supplyState;

	public Integer getSupplyId() {
		return supplyId;
	}

	public void setSupplyId(Integer supplyId) {
		this.supplyId = supplyId;
	}

	public String getSupplyNum() {
		return supplyNum;
	}

	public void setSupplyNum(String supplyNum) {
		this.supplyNum = supplyNum;
	}

	public String getSupplyName() {
		return supplyName;
	}

	public void setSupplyName(String supplyName) {
		this.supplyName = supplyName;
	}

	public String getSupplyIntroduce() {
		return supplyIntroduce;
	}

	public void setSupplyIntroduce(String supplyIntroduce) {
		this.supplyIntroduce = supplyIntroduce;
	}

	public String getConcat() {
		return concat;
	}

	public void setConcat(String concat) {
		this.concat = concat;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getSupplyState() {
		return supplyState;
	}

	public void setSupplyState(String supplyState) {
		this.supplyState = supplyState;
	}

	@Override
	public String toString() {
		return "Supply [supplyId=" + supplyId + ", supplyNum=" + supplyNum + ", supplyName=" + supplyName
				+ ", supplyIntroduce=" + supplyIntroduce + ", concat=" + concat + ", phone=" + phone + ", address="
				+ address + ", supplyState=" + supplyState + "]";
	}

}
