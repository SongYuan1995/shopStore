package com.byzx.authority.service;

import java.util.List;
import java.util.Map;

import com.byzx.authority.vo.Supply;


public interface SupplyService {
  
	public  List<Supply>  findAllSupply(Map map);
	
	public  Integer    getSupplyCount(Map map);

	public String  findSupplyBySupplyName(Supply supply);

	public String  findAllSupplyBysupplyNum(Supply supply);
	
	public Integer  insertsupply(Supply supply);

	public Integer  updataAllSupply(Supply supply);

	public Integer  deleteSupply(Integer supplyId);

	public List<Supply> findProSupplyList();
}
