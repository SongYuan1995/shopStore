package com.byzx.authority.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.byzx.authority.dao.BrandMapper;
import com.byzx.authority.service.BrandServlce;
import com.byzx.authority.vo.Brand;

/**
 * @Description: 品牌管理ServlceImpl
 * @ClassName: BrandServlceImpl
 * @date 2019年8月11日 下午5:15:22
 */
@Service
public class BrandServlceImpl implements BrandServlce {

	@Autowired
	private BrandMapper brandMapper;

	// 全查品牌
	@Override
	public List<Brand> fullCheckBrand(HashMap<String, Object> hm) {
		return brandMapper.fullCheckBrand(hm);
	}

	// 删除品牌
	@Override
	public boolean deleteBrand(String brandId) {
		Integer s = brandMapper.deleteBrand(brandId);
		return s != 1 ? true : false;
	}

	// 更新品牌信息
	@Override
	public boolean updateBrand(Brand brand) {
		Integer s = brandMapper.updateBrand(brand);
		return s != 1 ? true : false;
	}

	// 查询品牌名是否重复
	@Override
	public boolean repeatBrandName(Brand brand) {
		String brandId = brandMapper.repeatBrandName(brand);
		return null == brandId ? true : false;
	}

	// 添加品牌
	@Override
	public boolean addBrand(Brand brand) {
		Integer s = brandMapper.addBrand(brand);
		return s != 1 ? true : false;
	}

}
