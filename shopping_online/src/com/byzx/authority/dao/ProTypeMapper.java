package com.byzx.authority.dao;

import java.util.List;

import com.byzx.authority.vo.ProType;
import com.byzx.authority.vo.Specification;

import net.sf.json.JSONArray;

/**
 * @Description: 商品分类Mapper
 */
public interface ProTypeMapper {

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
	 * @return String    
	 * @throws
	 */
	public String isTypeName(String typeName);
	
	/**
	 * @Title: addShopType
	 * @Description: 添加分类   
	 * @return Integer    
	 */
	public Integer addShopType(ProType proType);
	
	/**
	 * @Title: shopTypeSpcId
	 * @Description: 查询当前分类的特性  
	 * @return String    
	 * @throws
	 */
	public String shopTypeSpcId(String typeId);
	
	/**
	 * @Title: updateShopType
	 * @Description: 更新分类   
	 * @return Integer    
	 */
	public Integer updateShopType(ProType proType);
	
	/**
	 * @Title: deleteShopType
	 * @Description: 删除分类   
	 * @return Integer    
	 */
	public Integer deleteShopType(String typeId);
	
	/**
	 * @Title: queryParendId
	 * @Description: 以父id查询id   
	 * @return String    
	 * @throws
	 */
	public List<String> queryParendId(String parendId);
	

}
