package com.byzx.authority.service;

import java.util.List;

import com.byzx.authority.vo.ProType;
import com.byzx.authority.vo.Specification;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * @Description: 商品分类Service
 * @ClassName: ProTyprService
 * @date 2019年8月12日 上午10:24:56
 */
public interface ProTyprService {
	
	/**
	 * @Title: shopType
	 * @Description: 全查商品分类   
	 * @return List<ProType>    
	 * @throws
	 */
	public List<ProType> shopType();

	/**
	 * @Title: querySpecification
	 * @Description: 查询所有特性     
	 * @return List<Specification>    
	 * @throws
	 */
	public List<Specification> querySpecification();
	
	/**
	 * @Title: isTypeName
	 * @Description: 判断分类名是否重复      
	 * @return boolean    
	 * @throws
	 */
	public boolean isTypeName(String typeName);
	
	/**
	 * @Title: addShopType
	 * @Description: 添加分类   
	 * @return boolean    
	 */
	public boolean addShopType(ProType proType);
	
	/**
	 * @Title: shopTypeSpcId
	 * @Description: 查询当前分类的特性  
	 * @return JSONArray    
	 * @throws
	 */
	public JSONArray shopTypeSpcId(String typeId);
	
	/**
	 * @Title: updateShopType
	 * @Description: 更新分类   
	 * @return boolean    
	 * @throws
	 */
	public boolean updateShopType(ProType proType);
	
	/**
	 * @Title: deleteShopType
	 * @Description: 删除分类   
	 * @return boolean    
	 * @throws
	 */
	public boolean deleteShopType(String typeId);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
