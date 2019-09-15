package com.byzx.authority.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.portlet.ModelAndView;

import com.byzx.authority.dao.ProductListMapper;
import com.byzx.authority.service.ProductListService;
import com.byzx.authority.vo.Address;
import com.byzx.authority.vo.Brand;
import com.byzx.authority.vo.Dictionary;
import com.byzx.authority.vo.PageUtil;
import com.byzx.authority.vo.ProSku;
import com.byzx.authority.vo.ProType;
import com.byzx.authority.vo.Product;
import com.byzx.authority.vo.Specification;
import com.byzx.authority.vo.StuIds;
import com.byzx.authority.vo.Supply;
import com.byzx.authority.vo.UserInfo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
@RequestMapping("/productList")
/**
 * @filename ProductListController.java
 * @author fish fly
 * @date 2019年8月19日 上午9:58:10
 * @version 1.0
 * Copyright (C) 2019 byzx
 */
public class ProductListController {
		
	@Autowired
	ProductListService productListService;
	
	
	/**
	 *@comment 显示商品列表
	 *@author fish fly
	 *@date 2019年8月19日 上午9:59:49
	 *@version 1.0
	 */
	@RequestMapping("/list.action")
	public void list(String order,Product product,Integer proState,Integer pageNum,HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		//为查询sql准备parameterType:map
			//获取模糊查询的参数（product:proName,typeId,proUpDown）prostate
		//System.out.println("*****list.action***"+product.toString());
		
		//为品牌下拉列表准备数据
		List<Brand> brands = productListService.findAllBrandName();
		request.getSession().setAttribute("BRANDS", brands);
		//为产地下拉列表准备数据
		List<Address> addresses = productListService.queryAllAddress();
		request.getSession().setAttribute("ADDRESSES", addresses);
		
		//为商品类型下拉列表准备数据
		List<ProType> proTypes =  productListService.findProType();
		request.getSession().setAttribute("PROTYPES",proTypes );
		//为供货商下拉列表准备数据
		List<Supply> supplies = productListService.queryAllSupply();
		request.getSession().setAttribute("SUPPLIES", supplies);
		
		
		
		Map<String,Object> map = new HashMap<String, Object>();
		//总条数
		Map<String,Object> map2 = new HashMap<String, Object>();
		String orderValue = "排序(销量)";
		if (order == null || order == "") {
			orderValue = "排序(销量)";
		}
		else if(order.equals("asc")) {
			orderValue = "升序(销量)";
		}
		else if(order.equals("desc")) {
			orderValue = "降序(销量)";
		}
		if (null != order) {
			map.put("Order", order);
		}
		
		if (null != product) {
			map.put("likeQuery", product);
			map2.put("likeQuery", product);
		}
		if (proState != null ) {
				map.put("proState", proState);
				map2.put("proState",proState );
		}
		request.setAttribute("orderValue", orderValue);
		//参数回显
		StringBuffer params = new StringBuffer();
		//params.append("orderValue="+orderValue);
		if (null != product.getProName()) {
			params.append("&proName="+product.getProName());
		}
		if (null != product.getTypeName()) {
			params.append("&typeName="+product.getTypeName());
		}
		if (null != product.getProUpDown()) {
			params.append("&proUpDown="+product.getProUpDown());
		}
		if (null != proState) {
			params.append("&proState="+proState);
		}
		
			
		
		
		//通过session获取当前用户的对象
		UserInfo ui = (UserInfo)request.getSession().getAttribute("USER");
		//掉用service的方法，并将结果存入session
		
		map.put("USERINFO", ui);
		System.out.println("store_id"+ui.toString());
		
		//封装分页信息
		pageNum = null != pageNum?pageNum:1;
		Integer pageSize = 6;
		PageUtil pu =new PageUtil(pageSize, pageNum);
		map.put("pageUtil", pu);
		List<Product> products = productListService.queryProductList(map);
		pu.setResultList(products);
		
		
		//总条数
		
		map2.put("USERINFO", ui);
		List<Product> products2 = productListService.queryProductList(map2);
		
		
		PageUtil page = new PageUtil(pageSize, products2.size(), pageNum, products, "/productList/list.action", params);
		request.getSession().setAttribute("page", page);
		request.getRequestDispatcher("/pages/productList.jsp").forward(request, response);
		
		
	}
	
	/**
	*@comment 修改商品上下架状态
	*@author fish fly
	*@date 2019年8月19日 上午9:59:49
	*@version 1.0
	*/
	@RequestMapping("/updateProUpDown.action")
	@ResponseBody
	public void updateProUpDown(Product product) {
		productListService.updateProUpDown(product);
	}
	
	/**
	*@comment 添加新商品
	*@author fish fly
	*@date 2019年8月19日 上午9:59:49
	*@version 1.0
	*/
	@RequestMapping("/addPic.action")
	public void addPic(@RequestParam("files") MultipartFile[] files,Product product,HttpServletRequest request,HttpServletResponse response) throws IOException {
		System.out.println("********/addPic.action");
		//通过session获取当前用户的对象
		UserInfo ui = (UserInfo)request.getSession().getAttribute("USER");
		//掉用service的方法，并将结果存入session
		if (ui.getStoreId().equals(0)) {
			product.setIsPlat("1");
		}
		else {
			product.setIsPlat("0");
		}
		System.out.println("product.getProPic"+product.getProPic());
		HashMap<String,Object> hashMap = new HashMap<String, Object>();
		
		
		String proPic="";
		if (null != files) {
			for (MultipartFile file : files) {
				if (!file.isEmpty()) {
					//设置文件保存路径
					String filePath2 = "upload/"+file.getOriginalFilename()+",";
					String filePath =request.getSession().getServletContext().getRealPath("/") +  "upload/"+file.getOriginalFilename();
					proPic += filePath2;
					//将路径存入product表的pic字段
//					product.setProPic(filePath2);
//					productListService.updateProPic(product);
					//转存文档
					try {
						file.transferTo(new File(filePath));
						
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			
		}
		product.setProPic(proPic);
		hashMap.put("PRODUCT", product);
		hashMap.put("USERINFO", ui);
		productListService.insertProduct(hashMap);
		response.sendRedirect(request.getContextPath()+"/productList/list.action");
	}

	/**
	*@comment 显示商品分类页面信息
	*@author fish fly
	*@date 2019年8月19日 上午9:59:49
	*@version 1.0
	*/
	@RequestMapping("/proType.action")
	public void proType(Product product,HttpServletRequest request,HttpServletResponse response) throws IOException {
		
		ProType pt = productListService.findTypeByTypeId(product);
		request.getSession().setAttribute("ProductOfUpdateType", product);
		List<ProType> types =  productListService.findProType();
		JSONArray ja = new JSONArray();
		for (ProType p : types) {
			JSONObject jo = new JSONObject();
			jo.put("id", p.getTypeId());
			jo.put("pId",p.getParentId() );
			jo.put("name",p.getTypeName() );
			if (p.getTypeId() == pt.getTypeId()) {
				jo.put("checked","true");
			}
//			jo.put("", );
//			jo.put("", );
//			jo.put("", );
			ja.add(jo);
		}
		request.getSession().setAttribute("JSON_ARRAY", ja);
		response.sendRedirect(request.getContextPath()+"/pages/proType.jsp");
	}
	/**
	*@comment 确认修改商品分类 
	*@author fish fly
	*@date 2019年8月19日 上午9:59:49
	*@version 1.0
	*/
	@RequestMapping("/updateType.action")
	public void updateProTyoe(Integer id,HttpServletRequest request,HttpServletResponse response) throws IOException {
		System.out.println("****/updateProTyoe.action**"+id);
		Product pro = (Product)request.getSession().getAttribute("ProductOfUpdateType");
		pro.setTypeId(Integer.valueOf(id));
		productListService.updateType(pro);
		response.sendRedirect(request.getContextPath()+"/productList/list.action");
	}

	
	@RequestMapping("/addNewPro.action")
	public void addNewPro(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
		
		
		//为产地下拉列表准备数据
		List<Address> addresses = productListService.queryAllAddress();
		request.getSession().setAttribute("ADDRESSES", addresses);
		//为品牌下拉列表准备数据
		List<Brand> brands = productListService.findAllBrandName();
		request.getSession().setAttribute("BRANDS",brands );
		//为商品类型下拉列表准备数据
		List<ProType> proTypes =  productListService.findProType();
		request.getSession().setAttribute("PROTYPES",proTypes );
		//为供货商下拉列表准备数据
		List<Supply> supplies = productListService.queryAllSupply();
		request.getSession().setAttribute("SUPPLIES", supplies);
		
		
		request.getRequestDispatcher("/pages/addNewPro.jsp").forward(request, response);
		
		
		
		
		
	}


	@RequestMapping("/addNewProType.action")
	public void addNewProType(Brand brand,Product product,HttpServletRequest request,HttpServletResponse response) throws IOException {
		//System.out.println("*********/addNewProType.action");
		
		List<ProType> types =  productListService.findProType();
		JSONArray ja = new JSONArray();
		for (ProType p : types) {
			JSONObject jo = new JSONObject();
			jo.put("id", p.getTypeId());
			jo.put("pId",p.getParentId() );
			jo.put("name",p.getTypeName() );
			ja.add(jo);
		}
		product.setBrand(brand);
		request.getSession().setAttribute("NewProduct", product);
		request.getSession().setAttribute("JSON_ARRAY", ja);
		response.sendRedirect(request.getContextPath()+"/pages/addNewProType.jsp");
		
	}

	
	@RequestMapping("/setNewProType.action")
	public void setNewProType(ProType proType,HttpServletRequest request,HttpServletResponse response) throws IOException {
		Product pro = (Product)request.getSession().getAttribute("NewProduct");
		pro.setProType(proType);
		request.getSession().setAttribute("NewProduct", pro);
		response.sendRedirect(request.getContextPath()+"/pages/addNewPro.jsp");
	}

	/**
	*@comment 修改商品信息页面显示
	*@author fish fly
	*@date 2019年8月19日 上午9:59:49
	*@version 1.0
	*/
	@RequestMapping("/updateProductInfo.action")
	public void updateProductInfo(Product product,HttpServletRequest request,HttpServletResponse response) throws IOException {
		Product pro = productListService.findProById(product);
		request.getSession().setAttribute("PRODUCT", pro);
		response.sendRedirect(request.getContextPath()+"/pages/updateProInfo.jsp");
	}

	/**
	*@comment 确认修改商品信息
	*@author fish fly
	*@date 2019年8月19日 上午9:59:49
	*@version 1.0
	*/
	@RequestMapping("/confirmUpdateProductInfo.action")
	public void confirmUpdateProductInfo(@RequestParam("files") MultipartFile[] files,Product product,HttpServletRequest request,HttpServletResponse response) throws IOException {
		HashMap<String,Object> map =new HashMap<String, Object>();	
		
		String proPic="";
		if (null != files) {
			for (MultipartFile file : files) {
				if (!file.isEmpty()) {
					//设置文件保存路径
					String filePath2 = "upload/"+file.getOriginalFilename()+",";
					String filePath =request.getSession().getServletContext().getRealPath("/") +  "upload/"+file.getOriginalFilename();
					proPic += filePath2;
					//转存文档
					try {
						file.transferTo(new File(filePath));
						
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			
		}
		product.setProPic(proPic);
		map.put("record", product);
		productListService.updateProInfo(map);
		productListService.updateProPic(product);
		response.sendRedirect(request.getContextPath()+"/productList/list.action");
	
	
	}

	/**
	*@comment sku页面显示
	*@author fish fly
	*@date 2019年8月19日 上午9:59:49
	*@version 1.0
	*/
	@RequestMapping("/setSku.action")
	public void setSku(Product product,HttpServletRequest request,HttpServletResponse response) throws IOException {
		//System.out.println("****/setSku.action****");
		Product pro = productListService.findProById(product);
		List<ProSku> skus = productListService.findAllSkuByProId(product.getProId());
//		if (skus == null || skus.size() == 0) {
//			response.sendRedirect(request.getContextPath()+"/pages/list.jsp");
//			return;
//		}
		
		
		List<Specification> spec = productListService.findSpecAndDicByTypeId(pro.getTypeId());
		List<String> list1 = new ArrayList<String>();
		List<String> list2 = new ArrayList<String>();
		for (int i = 0; i < spec.size(); i++) {
			for (int j = 0; j < spec.get(i).getDictionary().size(); j++) {
				String list = "\""+spec.get(i).getSpecCode()+"\""+":";
				list += spec.get(i).getDictionary().get(j).getDicId();
				System.out.println("list:"+list);
				if (i<1) {
					list1.add(list);
				}
				else if(i<=1) {
					list2.add(list);
				}
			}
		}
		List<String> end = new ArrayList<String>();
		if (list2.size()>0) {
			
			for (int i = 0; i < list1.size(); i++) {
				for (int j = 0; j < list2.size(); j++) {
					String temp = list1.get(i)+","+list2.get(j);
					end.add(temp);
				}
			}
			request.getSession().setAttribute("END", end);
		}
		else if (list2.size() == 0) {
			
			request.getSession().setAttribute("END", list1);
		}
		
		
		request.getSession().setAttribute("SPEC", spec);
		
		//修改1：开始
		//通过product寻找sku
		List<ProSku> proSkus = productListService.findAllSkuByProId(pro.getProId());
		if (null != proSkus && proSkus.size()>0) {
			request.getSession().setAttribute("UPDATESKU",proSkus );
			response.sendRedirect(request.getContextPath()+"/pages/updateSku.jsp");
			return;
		}
		//修改1：结束
		
		
		response.sendRedirect(request.getContextPath()+"/pages/setSku.jsp?proId="+pro.getProId());
	}

	/**
	*@comment 添加商品sku
	*@author fish fly
	*@date 2019年8月19日 上午9:59:49
	*@version 1.0
	*/
	@RequestMapping("readySku")
	public String readySku(@RequestParam("files") MultipartFile[] files,StuIds stuIds,HttpServletRequest request,HttpServletResponse response) {
			
		if (null != files) {
			for (int i=0;i< files.length; i++) {
				if (!files[i].isEmpty()) {
					//设置文件保存路径
					String filePath1 = request.getSession().getServletContext().getRealPath("/");
					String filePath2 = "upload/"+files[i].getOriginalFilename();
					String filePath = filePath1 + filePath2;
					
					Integer proId = stuIds.getProId()[i];
					Float inPrice = stuIds.getInPrices()[i];
					Float sellPrice = stuIds.getSellPrices()[i];
					Float inventory = stuIds.getInventorys()[i];
					String skuPic = filePath2;
					String state = stuIds.getStates()[i];
					String dicids = stuIds.getDicIds()[i];
					ProSku proSku = new ProSku(null, proId, inPrice, sellPrice, inventory, skuPic, state, dicids);
					productListService.insertSku(proSku);
					
					//转存文档
					try {
						files[i].transferTo(new File(filePath));
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			
		}
		
		
		
		
		
		
		
		
		return "redirect:../productList/list.action";
	}

	/**
	*@comment 修改商品sku页面显示
	*@author fish fly
	*@date 2019年8月19日 上午9:59:49
	*@version 1.0
	*/
	@RequestMapping("/updateSku.action")
	public String updateSku(Product pro,HttpServletRequest request) {
		//获得该商品已经添加的sku
		List<Specification> spec = productListService.findSpecAndDicByTypeId(pro.getTypeId());
		request.getSession().setAttribute("SPEC", spec);
		List<ProSku> proSkus = productListService.findAllSkuByProId(pro.getProId());
		if (proSkus.size()>0) {
			
			request.getSession().setAttribute("UPDATESKU",proSkus );
		}
		else {
			return "redirect:../productList/setSku.action?proId="+pro.getProId();
		}
		return "updateSku";
	}

	/**
	*@comment 确认修改商品sku
	*@author fish fly
	*@date 2019年8月19日 上午9:59:49
	*@version 1.0
	*/
	@RequestMapping("/confirmUpdateSku")
	public String confirmUpdateSku(@RequestParam("files") MultipartFile[] files,StuIds stuIds,HttpServletRequest request,HttpServletResponse response) {
		String filePath1 =null;
		String filePath2 =null;
		if (null != stuIds) {
			for (int i=0;i< stuIds.getSkuIds().length; i++) {
//				if (!files[i].isEmpty()) {
//					//设置文件保存路径
//					filePath1 = request.getSession().getServletContext().getRealPath("/");
//					filePath2 = "upload/"+files[i].getOriginalFilename();
//					String filePath = filePath1 + filePath2;
//
//					//转存文档
//					try {
//						files[i].transferTo(new File(filePath));
//					} catch (IllegalStateException e) {
//						e.printStackTrace();
//					} catch (IOException e) {
//						e.printStackTrace();
//					}
//				}
					Integer skuId = stuIds.getSkuIds()[i];
					Integer proId = stuIds.getProId()[i];
					Float inPrice = stuIds.getInPrices()[i];
					Float sellPrice = stuIds.getSellPrices()[i];
					Float inventory = stuIds.getInventorys()[i];
					String skuPic = filePath2;
					String state = stuIds.getStates()[i];
					String dicids = stuIds.getDicIds()[i];
					ProSku proSku = new ProSku(skuId, proId, inPrice, sellPrice, inventory, skuPic, state, dicids);
					System.out.println("proSku:*****"+proSku.toString());
					productListService.updateProSku(proSku);
					
				
			}
			
		}
		
		
		
		
		
		
		return "redirect:../productList/list.action";
		
	}


	/**
	*@comment 删除sku
	*@author fish fly
	*@date 2019年8月19日 上午9:59:49
	*@version 1.0
	*/
	@RequestMapping("/deleteSku.action")
	public String deleteSku(ProSku proSku,Product pro){
		
		productListService.deleteSku(proSku.getSkuId());
		
		
		return "redirect:../productList/updateSku.action?proId="+pro.getProId();
		
	}






}
