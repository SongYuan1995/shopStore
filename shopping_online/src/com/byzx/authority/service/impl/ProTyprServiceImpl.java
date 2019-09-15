package com.byzx.authority.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.byzx.authority.dao.ProTypeMapper;
import com.byzx.authority.service.ProTyprService;
import com.byzx.authority.vo.ProType;
import com.byzx.authority.vo.Specification;

import net.sf.json.JSONArray;

/**
 * @Description: 商品分类ServiceImpl
 * @ClassName: ProTyprServiceImpl
 * @date 2019年8月12日 上午11:20:35
 */
@Service
public class ProTyprServiceImpl implements ProTyprService {

	@Autowired
	private ProTypeMapper proTypeMapper;

	/**
	 * @Title: shopType
	 * @Description: 全查商品分类
	 * @see com.byzx.authority.service.ProTyprService#shopType()
	 */
	@Override
	public List<ProType> shopType() {
		return proTypeMapper.shopType();
	}

	/**
	 * @Title: querySpecification
	 * @Description: 查询所有特性
	 * @see com.byzx.authority.service.ProTyprService#querySpecification()
	 */
	@Override
	public List<Specification> querySpecification() {
		return proTypeMapper.querySpecification();
	}

	/**
	 * @Title: isTypeName
	 * @Description: 判断分类名是否重复
	 * @see com.byzx.authority.service.ProTyprService#isTypeName(java.lang.String)
	 */
	@Override
	public boolean isTypeName(String typeName) {
		String s = proTypeMapper.isTypeName(typeName);
		return null == s ? true : false;
	}

	/**
	 * @Title: addShopType
	 * @Description: 添加分类
	 * @see com.byzx.authority.service.ProTyprService#addShopType(com.byzx.authority.vo.ProType)
	 */
	@Override
	public boolean addShopType(ProType proType) {
		Integer s = proTypeMapper.addShopType(proType);
		return s != 1 ? true : false;
	}

	/**
	 * @Title: shopTypeSpcId
	 * @Description: 查询当前分类的特性
	 * @see com.byzx.authority.service.ProTyprService#shopTypeSpcId(java.lang.String)
	 */
	@Override
	public JSONArray shopTypeSpcId(String typeId) {
		JSONArray ja = new JSONArray();
		String spcIds = proTypeMapper.shopTypeSpcId(typeId);
		System.out.println("*ProTyprServiceImpl**shopTypeSpcId*spcIds=" + spcIds);
		if (null == spcIds || spcIds == "") {
			return ja;
		}
		for (String spcId : spcIds.split(",")) {
			ja.add(spcId);
		}
		return ja;
	}

	/**
	 * @Title: updateShopType
	 * @Description:更新分类
	 * @see com.byzx.authority.service.ProTyprService#updateShopType(com.byzx.authority.vo.ProType)
	 */
	@Override
	public boolean updateShopType(ProType proType) {
		Integer s = proTypeMapper.updateShopType(proType);
		return s != 1 ? true : false;
	}

	/**
	 * @Title: deleteShopType
	 * @Description: 删除分类
	 * @see com.byzx.authority.service.ProTyprService#deleteShopType(java.lang.String)
	 */
	@Override
	public boolean deleteShopType(String typeId) {
		// 1.递归查询该分类包含的子分类的id
		// 传过来的id为父id查询子id
		List<String> list = queryParendId("1");
		list.add(typeId);
		for (String s : list) {
			System.out.println("子id为=" + s);
		}
		// 2.在商品表查询type_id in(1) 有不删除 ,没有就删除

		//

		return false;
	}

	public List<String> queryParendId(String parendId) {
		List<String> list = proTypeMapper.queryParendId(parendId);// 以传过来的值为父id查
		List<String> typeIds = new ArrayList<>();// 用于存传过来的id的子id
		// System.out.println("以传过来的值为父id查="+list);
		if (!list.isEmpty()) {
			typeIds.addAll(list);
			for (String typeId1 : list) {
				List<String> list1 = proTypeMapper.queryParendId(typeId1);
				// System.out.println("第二次查的id="+list1);
				if (!list1.isEmpty()) {
					typeIds.addAll(list1);
					for (String typeId2 : list1) {
						List<String> list2 = queryParendId(typeId2);
						if (list2.isEmpty()) {
							break;
						} else {
							typeIds.addAll(list2);
						}
					}
				} else {
					continue;
				}
			}
		} else {
			return typeIds;
		}
		return typeIds;
	}

}
