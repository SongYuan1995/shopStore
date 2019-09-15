package com.byzx.authority.controller;

import java.io.IOException;
import java.util.HashMap;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.byzx.authority.service.BrandServlce;
import com.byzx.authority.vo.Brand;
import com.byzx.authority.vo.PageUtil;
import com.byzx.authority.vo.ShopStore;

import net.sf.json.JSONObject;

/**
 * @Description: 品牌Controller
 * @ClassName: BrandController
 * @date 2019年8月11日 下午1:56:16
 */
@Controller
@RequestMapping("/brand")
public class BrandController {

	@Autowired
	private BrandServlce brandServlce;
	{
		PageSize=6;
	}
	//一页显示几条,默认6条
	private Integer PageSize ;
	// 当前页码
	private Integer PageNum;
	//模糊查询数据
	private Brand brand;
	
	/**
	 * @Title: adminFullCheckBrand
	 * @Description: 查询所有品牌,模糊查询,分页  
	 * @return void    
	 * @throws
	 */
	@RequestMapping("/adminFullCheckBrand.action")
	public void adminFullCheckBrand(Integer bsh,Brand brand,PageUtil pageUtil,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		this.brand=brand;
		HashMap<String,Object> hm = new HashMap<>();
		hm.put("Brand", brand);
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
		if(null == brand.getBrandName()) {
			brand.setBrandName("");
		}
		if(null == brand.getBrandLeter()) {
			brand.setBrandLeter("");
		}
		hm1.put("Brand", brand);
		StringBuffer sb = new StringBuffer("&brandName="+brand.getBrandName()+"&brandLeter="+brand.getBrandLeter());
		PageUtil pageUtil2 = new PageUtil(pageUtil.getPageSize(), brandServlce.fullCheckBrand(hm1).size(), pageUtil.getPageNum(), brandServlce.fullCheckBrand(hm), "/brand/adminFullCheckBrand.action", sb);
		pageUtil2.setLimitIndex(pageUtil.getLimitIndex());
		//存入模糊搜索参数
		request.setAttribute("fuzzyQueryBrande", brand);
		//存入店铺信息和分页数据
		request.setAttribute("page", pageUtil2);
		//System.out.println("pageUtil2="+pageUtil2);
		request.getRequestDispatcher("/pages/brand-list.jsp").forward(request, response);
	}
	/**
	 * @Title: deleteBrand
	 * @Description: 删除品牌   
	 * @return void    
	 * @throws IOException 
	 * @throws ServletException 
	 */
	@RequestMapping("/deleteBrand.action")
	public void deleteBrand(String brandId,PageUtil pageUtil,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		pageUtil = new PageUtil(this.PageSize, this.PageNum);
		if(brandServlce.deleteBrand(brandId)) {//删除失败
			adminFullCheckBrand(0, brand, pageUtil, request, response);
		}else {//删除成功
			adminFullCheckBrand(1, brand, pageUtil, request, response);
		}
	}
	/**
	 * @throws IOException 
	 * @throws ServletException 
	 * @Title: updateBrand
	 * @Description: 更新商品信息  
	 * @return void    
	 * @bug 第一次进入都判断更新的信息是否与上次一致,解决方法,查数据库判断是传来的值与查出来的一致
	 */
	private String updatebrand;
	@RequestMapping("/updateBrand.action")
	public void updateBrand(Brand brand,PageUtil pageUtil,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//判断更新的信息是否与上次一致
		if((brand.toString()).equals(this.updatebrand)) {
			adminFullCheckBrand(null, this.brand, pageUtil, request, response);
			return;
		}
		//不一致存入全局变量
		this.updatebrand=brand.toString();
		pageUtil = new PageUtil(this.PageSize, this.PageNum);
		if(brandServlce.updateBrand(brand)) {//更新失败
			adminFullCheckBrand(5, this.brand, pageUtil, request, response);
		}else {//更新成功
			adminFullCheckBrand(6, this.brand, pageUtil, request, response);
		}
	}
	/**
	 * @Title: repeatBrandName
	 * @Description: 查询品牌名是否重复   
	 * @return JSONObject    
	 * @throws
	 */
	@RequestMapping("/repeatBrandName.action")
	@ResponseBody
	public JSONObject repeatBrandName(Brand brand) {
		JSONObject jo = new JSONObject();
		if(brandServlce.repeatBrandName(brand)) {//无品牌名
			jo.put("pd", true);
		}else {//有品牌名
			jo.put("pd", false);
		}
		return jo;
	} 
	/**
	 * @throws IOException 
	 * @throws ServletException 
	 * @Title: addBrand
	 * @Description: 添加品牌   
	 * @return void    
	 * @throws
	 */
	@RequestMapping("/addBrand.action")
	public void addBrand(Brand brand,PageUtil pageUtil,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		pageUtil = new PageUtil(this.PageSize, this.PageNum);
		JSONObject jo = repeatBrandName(brand);
		if(!(boolean)jo.get("pd")) {//判断添加品牌名是否重复
			adminFullCheckBrand(null, this.brand, pageUtil, request, response);
			return;
		}
		if(brandServlce.addBrand(brand)) {//添加失败
			adminFullCheckBrand(4, this.brand, pageUtil, request, response);
		}else {//添加成功
			adminFullCheckBrand(3, this.brand, pageUtil, request, response);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
