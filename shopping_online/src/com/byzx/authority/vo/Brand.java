package com.byzx.authority.vo;

import java.io.Serializable;

/**
 * @Description: 品牌Bean
 * @ClassName: Brand
 * @date 2019年8月11日 下午2:12:59
 */
public class Brand implements Serializable {

	private static final long serialVersionUID = 4097635487346694316L;
	// 品牌id
	private Integer brandId;
	// 品牌名
	private String brandName;
	// 品牌首字母
	private String brandLeter;
	// 品牌介绍
	private String brandDesc;

	public Integer getBrandId() {
		return brandId;
	}

	public void setBrandId(Integer brandId) {
		this.brandId = brandId;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName == null ? null : brandName.trim();
	}

	public String getBrandLeter() {
		return brandLeter;
	}

	public void setBrandLeter(String brandLeter) {
		this.brandLeter = brandLeter == null ? null : brandLeter.trim();
	}

	public String getBrandDesc() {
		return brandDesc;
	}

	public void setBrandDesc(String brandDesc) {
		this.brandDesc = brandDesc == null ? null : brandDesc.trim();
	}

	@Override
	public String toString() {
		return "Brand [brandId=" + brandId + ", brandName=" + brandName + ", brandLeter=" + brandLeter + ", brandDesc="
				+ brandDesc + "]";
	}

}