package com.byzx.authority.vo;

import java.io.Serializable;
import java.util.List;

/**
 * @Description: TODO
 * @ClassName: Specification
 * @date 2019年8月12日 下午1:19:14
 */
public class Specification implements Serializable {
	private static final long serialVersionUID = 5379892288268307118L;
	// 特性id
	private Integer spcId;
	private Integer typeId;  
	
	
    public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}
	//与dictionary表关联：1-多
    private List<Dictionary> dictionary;
	
	public List<Dictionary> getDictionary() {
		return dictionary;
	}

	public void setDictionary(List<Dictionary> dictionary) {
		this.dictionary = dictionary;
	}
	// 特性名称
	private String spcName;
	// 状态
	private String state;
	// 排序
	private Integer rank;
	// 特性代码
	private String specCode;

	public Integer getSpcId() {
		return spcId;
	}

	public void setSpcId(Integer spcId) {
		this.spcId = spcId;
	}

	public String getSpcName() {
		return spcName;
	}

	public void setSpcName(String spcName) {
		this.spcName = spcName == null ? null : spcName.trim();
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state == null ? null : state.trim();
	}

	public Integer getRank() {
		return rank;
	}

	public void setRank(Integer rank) {
		this.rank = rank;
	}

	public String getSpecCode() {
		return specCode;
	}

	public void setSpecCode(String specCode) {
		this.specCode = specCode == null ? null : specCode.trim();
	}

	@Override
	public String toString() {
		return "Specification [spcId=" + spcId + ", spcName=" + spcName + ", state=" + state + ", rank=" + rank
				+ ", specCode=" + specCode + "]";
	}

}