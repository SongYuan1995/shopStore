package com.byzx.authority.dao;

import java.util.HashMap;
import java.util.List;

import com.byzx.authority.vo.Brand;

public interface BrandMapper {

	// 全查品牌
	public List<Brand> fullCheckBrand(HashMap<String, Object> hm);

	// 删除品牌
	public Integer deleteBrand(String brandId);

	// 更新品牌信息
	public Integer updateBrand(Brand brand);

	// 查询品牌名是否重复
	public String repeatBrandName(Brand brand);

	// 添加品牌
	public Integer addBrand(Brand brand);

}
