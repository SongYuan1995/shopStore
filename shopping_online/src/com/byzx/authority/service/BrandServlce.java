package com.byzx.authority.service;

import java.util.HashMap;
import java.util.List;

import com.byzx.authority.vo.Brand;

import net.sf.json.JSONObject;

public interface BrandServlce {

	// 全查品牌
	public List<Brand> fullCheckBrand(HashMap<String, Object> hm);

	// 删除品牌
	public boolean deleteBrand(String brandId);

	// 更新品牌信息
	public boolean updateBrand(Brand brand);

	// 查询品牌名是否重复
	public boolean repeatBrandName(Brand brand);

	// 添加品牌
	public boolean addBrand(Brand brand);

}
