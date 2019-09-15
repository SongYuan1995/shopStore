package com.byzx.authority.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.byzx.authority.service.ShopServict;
import com.byzx.authority.vo.PageUtil;
import com.byzx.authority.vo.ShopStore;
import com.byzx.authority.vo.UserInfo;

import net.sf.json.JSONObject;

/**
 * @Description: 店铺管理
 * @ClassName: ShopManager
 * @author 
 * @date 2019年8月8日 上午11:34:41
 */

@Controller
@RequestMapping("/shop")
public class ShopController {
	
	@Autowired
	private ShopServict shopServlct;
	
	{
		PageSize=6;
	}
	//一页显示几条,默认6条
	private Integer PageSize ;
	// 当前页码
	private Integer PageNum;
	//模糊查询数据
	private ShopStore shopStore;
	
	/**
	 * @throws ServletException 
	 * @throws IOException 
	 * @Title: userType
	 * @Description: 判断用户   1管理员,2客服,3店长 
	 * @return void    
	 * @throws
	 */
	
	@RequestMapping("/userType.action")
	public void userType(Integer bsh,ShopStore shopStore,PageUtil pageUtil,HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
		UserInfo userInfo = (UserInfo)request.getSession().getAttribute("USER");
		if(null == userInfo) {
			response.sendRedirect("../pages/login.jsp");
			return;
		}
		if(userInfo.getUserType().equals("0")) {//超级管理员
			adminFullCheckShop(bsh, shopStore, pageUtil, request, response);
		}else if(userInfo.getUserType().equals("1")) {//自营店主
			bossShop(request, pageUtil, response);
		}else if(userInfo.getUserType().equals("3")){//店长
			bossShop(request, pageUtil, response);
		}else if(userInfo.getUserType().equals("2")) {//客服
			bossShop(request, pageUtil, response);
		}
	}
	/**
	 * @throws IOException 
	 * @throws ServletException 
	 * @Title: FullCheckShop
	 * @Description: 管理员查询全部店铺   
	 * @return void    
	 * @throws
	 */
	@RequestMapping("/adminFullCheckShop.action")
	public void adminFullCheckShop(Integer bsh,ShopStore shopStore,PageUtil pageUtil,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		this.shopStore=shopStore;
		HashMap<String,Object> hm = new HashMap<>();
		hm.put("ShopStore", shopStore);
		if(null == pageUtil.getPageNum()) {
			pageUtil.setPageNum(1);
		}
		this.PageNum=pageUtil.getPageNum();
		if(null != pageUtil.getPageSize()) {
			this.PageSize = pageUtil.getPageSize();
			
		}else {
			pageUtil.setPageSize(this.PageSize);
		}
		if(null == pageUtil.getLimitIndex()) {
			pageUtil.setLimitIndex(0);
		}
		hm.put("PageUtil", pageUtil);
		HashMap<String,Object> hm1 = new HashMap<>();
		if(null == shopStore.getStoreName()) {
			shopStore.setStoreName("");
		}
		if(null == shopStore.getStoreState()) {
			shopStore.setStoreState("");
		}
		hm1.put("ShopStore", shopStore);
		StringBuffer sb = new StringBuffer("&storeName="+shopStore.getStoreName()+"&storeState="+shopStore.getStoreState());
		PageUtil pageUtil2 = new PageUtil(pageUtil.getPageSize(), shopServlct.fullCheckShop(hm1).size(), pageUtil.getPageNum(), shopServlct.fullCheckShop(hm), "/shop/adminFullCheckShop.action", sb);
		pageUtil2.setLimitIndex(pageUtil.getLimitIndex());
	
		//存入所有店长
		//System.out.println("所有店长="+shopServlct.queryAllBoss());
		request.setAttribute("queryAllBoss",shopServlct.queryAllBoss());
		//存入模糊搜索参数
		request.setAttribute("fuzzyQueryShopStore", shopStore);
		//存入店铺信息和分页数据
		request.setAttribute("page", pageUtil2);
		//System.out.println("pageUtil2="+pageUtil2);
		//存入分页标识
		request.setAttribute("shopFuzzyQuery", 0);
		request.getRequestDispatcher("/pages/shop-list.jsp").forward(request, response);
	}
	
	/**
	 * @throws IOException 
	 * @throws ServletException 
	 * @Title: adminStatus
	 * @Description: 管理员禁用启用店铺   
	 * @return void    
	 * @throws
	 */
	@RequestMapping("/adminStatus.action")
	public void adminStatus(ShopStore shopStore,PageUtil pageUtil,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		pageUtil = new PageUtil(this.PageSize, this.PageNum);
		if(shopServlct.adminStatus(shopStore)) {//禁用启用失败
			adminFullCheckShop(2, this.shopStore, pageUtil, request, response);
		}else {//禁用启用成功
			adminFullCheckShop(null, this.shopStore, pageUtil, request, response);
		}
	}
	
	/**
	 * @Title: addShop
	 * @Description: 添加店铺   
	 * @return void    
	 * @throws
	 */
	
	@RequestMapping("/addShop.action")
	public void addShop(ShopStore shopStore,String userShop,PageUtil pageUtil,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//店铺名,店主,联系电话,店铺介绍
		pageUtil = new PageUtil(this.PageSize, this.PageNum);
		if(shopServlct.addShop(shopStore,userShop)) {//添加失败
			adminFullCheckShop(4, this.shopStore, pageUtil, request, response);
		}else {//添加成功
			adminFullCheckShop(3, this.shopStore, pageUtil, request, response);
		}
	}
	
	/**
	 * @Title: repeatShop
	 * @Description: 查询店铺名是否重复   
	 * @return JSONObject    
	 * @throws
	 */
	
	@RequestMapping("/repeatShop.action")
	@ResponseBody
	public JSONObject repeatShop(ShopStore shopStore) {
		//System.out.println("传参的用户名="+userName);
		JSONObject jo = new JSONObject();
		if(shopServlct.repeatShop(shopStore)) {//无用户
			jo.put("pd", true);
		}else {//有用户
			jo.put("pd", false);
		}
		return jo;
	} 
	
	/**
	 * @Title: repeatBoss
	 * @Description: 查询店长是否绑定店铺   
	 * @return JSONObject    
	 * @throws
	 */
	@RequestMapping("/repeatBoss.action")
	@ResponseBody
	public JSONObject repeatBoss(String userCode) {
		//System.out.println("传参的用户名="+userName);
		JSONObject jo = new JSONObject();
		if(shopServlct.repeatBoss(userCode)) {//无店铺
			jo.put("pd", true);
		}else {//有店铺
			jo.put("pd", false);
		}
		return jo;
	} 
	
	/**
	 * @throws IOException 
	 * @throws ServletException 
	 * @Title: updateShop
	 * @Description: 更新店铺信息   
	 * @return void    
	 */
	@RequestMapping("/updateShop.action")
	public void updateShop(ShopStore shopStore,String updateStoreHost,PageUtil pageUtil,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ShopStore="+shopStore+"   店长信息userShop="+updateStoreHost);
		pageUtil = new PageUtil(this.PageSize, this.PageNum);
		if(shopServlct.updateShop(shopStore,updateStoreHost)) {
			//更新成功
			adminFullCheckShop(6, this.shopStore, pageUtil, request, response);
		}else {
			//更新失败
			adminFullCheckShop(5, this.shopStore, pageUtil, request, response);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * @throws IOException 
	 * @throws ServletException 
	 * @Title: bossShop
	 * @Description: 店长登录查询店铺   
	 * @return void    
	 */
	@RequestMapping("/bossShop.action")
	public void bossShop(HttpServletRequest request,PageUtil pageUtil,HttpServletResponse response) throws ServletException, IOException {
		UserInfo userInfo = (UserInfo)request.getSession().getAttribute("USER");
		List<ShopStore> list = new ArrayList<>();
		list.add(shopServlct.bossShop(userInfo));
		pageUtil.setResultList(list);
		request.setAttribute("page", pageUtil);
		request.getRequestDispatcher("/pages/shop-list.jsp").forward(request, response);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
