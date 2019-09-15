package com.byzx.authority.dao;

import java.util.List;
import java.util.Map;

import com.byzx.authority.vo.Supply;


/**
 * @文件名: SupplyMapper.java
 * @类功能说明: 供货商信息Mapper层
 * @修改说明:<br> 
 */
public interface SupplyMapper {
/**
 * @方法名: findAllSupply
 * @方法说明: 供货商信息展示
 * @param map
 * @return
 * @return: List<Supply>
 */
	public List<Supply>  findAllSupply(Map map);
	/**
	 * @方法名: getSupplyCount
	 * @方法说明:供货商信息分页总条数 
	 * @param map
	 * @return
	 * param:
	 * @return: Integer
	 */
	public Integer  getSupplyCount(Map map);
	/**
	 * @方法名: findSupplyBySupplyName
	 * @方法说明:供货商信息根据名称判断名称唯一性 
	 * @param supply
	 * @return
	 * @return: String
	 */
	public String  findSupplyBySupplyName(Supply supply);
	/**
	 * @方法名: findAllSupplyBysupplyNum
	 * @方法说明: 供货商信息根据编号判断编号唯一性 
	 * @param supply
	 * @return: String
	 */
	public String  findAllSupplyBysupplyNum(Supply supply);
	/**
	 * @方法名: insertsupply
	 * @方法说明: 供货商信息添加
	 * @param supply
	 * @return: Integer
	 */
	public Integer insertsupply(Supply supply);
	/**
	 * @方法名: updataAllSupply
	 * @方法说明: 供货商信息修改
	 * @param supply
	 * @return: Integer
	 */
	public Integer updataAllSupply(Supply supply);
	/**
	 * @方法名: deleteSupply
	 * @方法说明: 供货商信息删除
	 * @param supplyId
	 * @return: Integer
	 */
	public Integer deleteSupply(Integer supplyId);
	/**
	 * @方法名: findProSupplyList
	 * @方法说明: 供应商下拉框Mapper
	 * @return: List<Supply>
	 */
	public List<Supply> findProSupplyList();
}