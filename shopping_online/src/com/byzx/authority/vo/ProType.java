package com.byzx.authority.vo;

import java.io.Serializable;

/**
 * @Description: 商品分类JavaBean
 * @ClassName: ProType
 * @date 2019年8月12日 上午10:22:41
 */
public class ProType implements Serializable {

	private static final long serialVersionUID = 8627863460124225388L;
	// 分类id
	private Integer typeId;
	// 分类名称
	private String typeName;
	// 分类描述
	private String typeDesc;
	// 分类父id
	private Integer parentId;
	// 特性ids
	private String specids;

	public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName == null ? null : typeName.trim();
	}

	public String getTypeDesc() {
		return typeDesc;
	}

	public void setTypeDesc(String typeDesc) {
		this.typeDesc = typeDesc == null ? null : typeDesc.trim();
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getSpecids() {
		return specids;
	}

	public void setSpecids(String specids) {
		this.specids = specids == null ? null : specids.trim();
	}

	@Override
	public String toString() {
		return "ProType [typeId=" + typeId + ", typeName=" + typeName + ", typeDesc=" + typeDesc + ", parentId="
				+ parentId + ", specids=" + specids + "]";
	}

}