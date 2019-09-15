package com.byzx.authority.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.byzx.authority.dao.ShopMapper;
import com.byzx.authority.service.ShopServict;
import com.byzx.authority.vo.ShopStore;
import com.byzx.authority.vo.UserInfo;

/**
 * 
 * @author Administrator
 * @date 2019年8月16日
 * @param
 */
@Service
public class ShopServictImpl implements ShopServict {

	@Autowired
	private ShopMapper shopMapper;

	// 查询全部店铺
	@Override
	public List<ShopStore> fullCheckShop(HashMap<String, Object> hm1) {
		return shopMapper.fullCheckShop(hm1);
	}

	// 查询所有店长
	@Override
	public List<UserInfo> queryAllBoss() {
		return shopMapper.queryAllBoss();
	}

	// 禁用启用店铺
	@Override
	public boolean adminStatus(ShopStore shopStore) {
		Integer s = shopMapper.adminStatus(shopStore);
		if (s != 1) {
			return true;
		}
		return false;
	}

	// 添加店铺
	@Override
	@Transactional
	public boolean addShop(ShopStore shopStore, String userShop) {
		// 获取用户id
		String userId = userShop.substring(0, userShop.indexOf(","));
		// 获取用户名
		String userName = userShop.substring(userShop.indexOf(",") + 1);
		// System.out.println("*ShopServictImpl**addShop**userId="+userId+"userName="+userName);
		shopStore.setStoreHost(userName);
		Integer add = shopMapper.addShop(shopStore);
		Integer update = shopMapper.bindingShop(userId);
		return add != update ? true : false;
	}

	// 查询店铺名是否重复
	@Override
	public boolean repeatShop(ShopStore shopStore) {
		String s = shopMapper.repeatShop(shopStore);
		return s == null ? true : false;
	}

	// 查询店长是否绑定店铺
	@Override
	public boolean repeatBoss(String userCode) {
		// 获取店长名
		userCode = userCode.substring(userCode.indexOf(",") + 1);
		String s = shopMapper.repeatBoss(userCode);
		return null == s ? true : false;
	}

	// 更新店铺信息
	@Override
	@Transactional
	public boolean updateShop(ShopStore shopStore, String updateStoreHost) {
		// 获取店长id
		String userId = updateStoreHost.substring(0, updateStoreHost.indexOf(","));
		// 获取店长名
		String userName = updateStoreHost.substring(updateStoreHost.indexOf(",") + 1);
		// System.out.println("*ShopServictImpl**updateShop**userId="+userId+"userName="+userName);
		shopStore.setStoreHost(userName);
		// 获取当前店铺id
		Integer shopId = shopStore.getStoreId();
		// 更新时给店长绑定店铺
		Map<String, Object> m = new HashMap<>();
		m.put("shopId", shopId);
		m.put("userId", userId);
		Integer bindingShopIsNull = shopMapper.bindingShopIsNull(shopId + "");// 解除当前店长绑定的店铺
		Integer updateShop = shopMapper.updateShop(shopStore);// 更新店铺信息
		Integer updateBoss = shopMapper.updateBoss(m);// 给店长绑定更新的店铺
		return bindingShopIsNull == 1 && updateShop == 1 && updateBoss == 1 ? true : false;
	}

	// 店长登录查询店铺
	@Override
	public ShopStore bossShop(UserInfo userInfo) {
		return shopMapper.bossShop(userInfo);
	}

}
