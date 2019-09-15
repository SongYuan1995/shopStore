package com.byzx.authority.service;

import java.util.HashMap;
import java.util.List;

import com.byzx.authority.vo.ShopStore;
import com.byzx.authority.vo.UserInfo;

public interface ShopServict {

	// 查询全部店铺
	public List<ShopStore> fullCheckShop(HashMap<String, Object> hm1);

	// 查询所有店长
	public List<UserInfo> queryAllBoss();

	// 禁用启用店铺
	public boolean adminStatus(ShopStore shopStore);

	// 添加店铺
	public boolean addShop(ShopStore shopStore, String userShop);

	// 查询店铺名是否重复
	public boolean repeatShop(ShopStore shopStore);

	// 查询店长是否绑定店铺
	public boolean repeatBoss(String userCode);

	// 更新店铺信息
	public boolean updateShop(ShopStore shopStore, String userShop);

	// 店长登录查询店铺
	public ShopStore bossShop(UserInfo userInfo);
}
