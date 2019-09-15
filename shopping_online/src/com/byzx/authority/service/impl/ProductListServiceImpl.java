package com.byzx.authority.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.byzx.authority.dao.ProductListMapper;
import com.byzx.authority.service.ProductListService;
import com.byzx.authority.vo.Address;
import com.byzx.authority.vo.Brand;
import com.byzx.authority.vo.ProSku;
import com.byzx.authority.vo.ProType;
import com.byzx.authority.vo.Product;
import com.byzx.authority.vo.Specification;
import com.byzx.authority.vo.Supply;
@Service
public class ProductListServiceImpl implements ProductListService{
	@Autowired
	ProductListMapper productListMapper;
	/**
	 * @author fish fly
	 * @comment 全查店铺商品	
	 * @return
	 */
	@Override
	public List<Product> queryProductList(Map<String,Object> map) {
		return productListMapper.queryProductList(map);
	}
	
	/**
	 * @author Song Yuan
	 * @comment 更改商品上下架状态	
	 * @return
	 */
	@Override
	public void updateProUpDown(Product product) {
		productListMapper.updateProUpDown(product);
	}
	
	
	/**
	 * @author Song Yuan
	 * @comment 设置商品图片src	
	 * @return
	 */
	@Override
	public void updateProPic(Product product) {
		productListMapper.updateProPic(product);
	}
	
	
	
	/**
	 * @author Song Yuan
	 * @comment 全查品牌表，为修改商品信息中的品牌下拉列表准备数据	
	 * @return
	 */
	@Override
	public List<Brand> findAllBrandName() {
		return productListMapper.findAllBrandName();
	}

	
	/**
	 * @author Song Yuan
	 * @comment 全查商品分类表
	 * @return
	 */
	@Override
	public List<ProType> findProType() {
		return productListMapper.findProType();
	}
	
	
	/**
	 * @author Song Yuan
	 * @comment 查询指定商品分类
	 * @return
	 */
	@Override
	public ProType findTypeByTypeId(Product product) {
		return productListMapper.findTypeByTypeId(product);
	}

	
	/**
	 * @author Song Yuan
	 * @comment 修改指定商品分类
	 * @return
	 */
	@Override
	public void updateType(Product product) {
		productListMapper.updateType(product);
	}
	

	/**
	 * @author Song Yuan
	 * @comment 全查产地表
	 * @return
	 */
	@Override
	public List<Address> queryAllAddress() {
		return productListMapper.queryAllAddress();
	}
	


	/**
	 * @author Song Yuan
	 * @comment 全查gong'huo's表
	 * @return
	 */
	@Override
	public List<Supply> queryAllSupply() {
		return productListMapper.queryAllSupply();
	}

	
	
	/**
	 * @author Song Yuan
	 * @comment 添加新商品
	 * @return
	 */
	@Override
	public void insertProduct(HashMap<String, Object> hashMap) {
		productListMapper.insertProduct(hashMap);
	}

	
	
	
	
	/**
	 * @author Song Yuan
	 * @comment 根据商品id查询商品
	 * @return
	 */
	@Override
	public Product findProById(Product product) {
		return productListMapper.findProById(product);
	}
	
	
	
	/**
	 * @author Song Yuan
	 * @comment 修改商品信息
	 * @return
	 */
	@Override
	public void updateProInfo(HashMap<String, Object> hashMap) {
		productListMapper.updateProInfo(hashMap);
	}

	
	/**
	 * @author Song Yuan
	 * @comment 查询商品所有特性
	 * @return
	 */
	@Override
	public List<Specification> findSpecAndDicByTypeId(Integer typeId) {
		return productListMapper.findSpecAndDicByTypeId(typeId);
	}

	
	/**
	 * @author Song Yuan
	 * @comment 生成sku
	 * @return
	 */
	@Override
	public void insertSku(ProSku proSku) {
		productListMapper.insertSku(proSku);
	}

	
	/**
	 * @author Song Yuan
	 * @comment 查询商品已有id
	 * @return
	 */
	@Override
	public List<ProSku> findAllSkuByProId(Integer proId) {
		return productListMapper.findAllSkuByProId(proId);
	}

	
	
	
	/**
	 * @author Song Yuan
	 * @comment 修改商品sku
	 * @return
	 */
	@Override
	public int updateProSku(ProSku proSku) {
		return productListMapper.updateProSku(proSku);
	}
	
	
	
	/**
	 * @author Song Yuan
	 * @comment 删除商品sku
	 * @return
	 */
	@Override
	public int deleteSku(Integer skuId) {
		return productListMapper.deleteSku(skuId);
	}

	
	
	
	
	
	
	
	
	
	
	
}
