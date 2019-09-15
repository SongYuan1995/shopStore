package com.byzx.authority.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.byzx.authority.dao.SupplyMapper;
import com.byzx.authority.service.SupplyService;
import com.byzx.authority.vo.Supply;

/**
 * 
 * @author Administrator
 * @date 2019年8月16日
 * @param
 */
@Service
public class SupplyServiceImpl implements SupplyService {
	@Autowired
	private SupplyMapper supplyMapper;

	@Override
	public List<Supply> findAllSupply(Map map) {

		return supplyMapper.findAllSupply(map);
	}

	@Override
	public Integer getSupplyCount(Map map) {
		return supplyMapper.getSupplyCount(map);
	}

	@Override
	public String findSupplyBySupplyName(Supply supply) {

		return supplyMapper.findSupplyBySupplyName(supply);
	}

	@Override
	public String findAllSupplyBysupplyNum(Supply supply) {

		return supplyMapper.findAllSupplyBysupplyNum(supply);
	}

	@Override
	public Integer insertsupply(Supply supply) {
		return supplyMapper.insertsupply(supply);
	}

	@Override
	public Integer updataAllSupply(Supply supply) {
		return supplyMapper.updataAllSupply(supply);
	}

	@Override
	public Integer deleteSupply(Integer supplyId) {
		return supplyMapper.deleteSupply(supplyId);
	}

	@Override
	public List<Supply> findProSupplyList() {
		return supplyMapper.findProSupplyList();
	}

}
