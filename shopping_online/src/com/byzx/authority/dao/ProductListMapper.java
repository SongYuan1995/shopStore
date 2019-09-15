package com.byzx.authority.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.text.html.HTMLDocument.HTMLReader.SpecialAction;

import com.byzx.authority.vo.Address;
import com.byzx.authority.vo.Brand;
import com.byzx.authority.vo.ProSku;
import com.byzx.authority.vo.ProType;
import com.byzx.authority.vo.Product;
import com.byzx.authority.vo.Specification;
import com.byzx.authority.vo.Supply;

public interface ProductListMapper {
	/**
	 * @author Song Yuan
	 * @comment 全查店铺商品	
	 * @return
	 */
	public List<Product> queryProductList(Map<String,Object> map);
	
	/**
	 * @author Song Yuan
	 * @comment 更改商品上下架状态	
	 * @return
	 */
	public void updateProUpDown(Product product);
	
	/**
	 * @author Song Yuan
	 * @comment 设置商品图片src	
	 * @return
	 */
	public void updateProPic(Product product);
	
	/**
	 * @author Song Yuan
	 * @comment 全查品牌表，为修改商品信息中的品牌下拉列表准备数据	
	 * @return
	 */
	public List<Brand> findAllBrandName();
	
	
	/**
	 * @author Song Yuan
	 * @comment 全查商品分类表
	 * @return
	 */
	public List<ProType> findProType();
	
	
	/**
	 * @author Song Yuan
	 * @comment 查询指定商品分类
	 * @return
	 */
	public ProType findTypeByTypeId(Product product);
	
	/**
	 * @author Song Yuan
	 * @comment 修改指定商品分类
	 * @return
	 */
	public void updateType(Product product);
	
	/**
	 * @author Song Yuan
	 * @comment 全查产地表
	 * @return
	 */
	public List<Address> queryAllAddress();
	
	
	
	
	/**
	 * @author Song Yuan
	 * @comment 全查供货商表
	 * @return
	 */
	public List<Supply> queryAllSupply();
	
	/**
	 * @author Song Yuan
	 * @comment 添加新商品
	 * @return
	 */
	public void insertProduct(HashMap<String,Object> hashMap);
	
	/**
	 * @author Song Yuan
	 * @comment 根据商品id查询商品
	 * @return
	 */
	public Product findProById(Product product);
	

	/**
	 * @author Song Yuan
	 * @comment 修改商品信息
	 * @return
	 */
	public void updateProInfo(HashMap<String,Object> hashMap);
	
	
	/**
	 * @author Song Yuan
	 * @comment 查询商品所有特性
	 * @return
	 */
	public List<Specification> findSpecAndDicByTypeId(Integer typeId);
	
	/**
	 * @author Song Yuan
	 * @comment 生成sku
	 * @return
	 */
	public void insertSku(ProSku proSku);
	
	
	
	/**
	 * @author Song Yuan
	 * @comment 查询商品已有id
	 * @return
	 */
	public List<ProSku> findAllSkuByProId(Integer proId);
	
	
	/**
	 * @author Song Yuan
	 * @comment 修改商品sku
	 * @return
	 */
	public int updateProSku(ProSku proSku);
	
	
	

	/**
	 * @author Song Yuan
	 * @comment 删除sku
	 * @return
	 */
	public int deleteSku(Integer skuId);
	
	
	
	
	
	
	
}
