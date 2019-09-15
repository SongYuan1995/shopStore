package com.byzx.authority.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.byzx.authority.vo.ShopStore;
import com.byzx.authority.vo.UserInfo;

/**
 * @Description: 店铺管理Mapper
 * @ClassName: ShopMapper
 */
public interface ShopMapper {

	// 查询全部店铺
	public List<ShopStore> fullCheckShop(HashMap<String, Object> hm1);

	// 查询所有店长
	public List<UserInfo> queryAllBoss();

	// 禁用启用店铺
	public Integer adminStatus(ShopStore shopStore);

	// 添加店铺
	public Integer addShop(ShopStore shopStore);

	// 给店长绑定店铺
	public Integer bindingShop(String userId);

	// 查询店铺名是否重复
	public String repeatShop(ShopStore shopStore);

	// 查询店长是否绑定店铺
	public String repeatBoss(String userCode);

	// 更新店铺信息时把原店长店铺清空
	public Integer bindingShopIsNull(String shopId);

	// 更新店铺信息
	public Integer updateShop(ShopStore shopStore);

	// 更新时给店长绑定店铺
	public Integer updateBoss(Map<String, Object> m);

	// 店长登录查询店铺
	public ShopStore bossShop(UserInfo userInfo);
	
}
