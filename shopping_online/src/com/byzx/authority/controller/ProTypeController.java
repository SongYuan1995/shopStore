package com.byzx.authority.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.byzx.authority.service.ProTyprService;
import com.byzx.authority.vo.ProType;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * @Description: 商品分类Controller
 * @ClassName: ProTypeController
 * @author 
 * @date 2019年8月12日 上午9:55:39
 */
@Controller
@RequestMapping("/proType")
public class ProTypeController {
	
	@Autowired
	private ProTyprService proTyprService;
	/**
	 * @Title: shopType
	 * @Description: 全查商品分类   
	 * @return void    
	 * @throws IOException 
	 * @throws ServletException 
	 */
	
	@RequestMapping("/shopProType")
	public String shopType(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		List<ProType> proType = proTyprService.shopType();
		//System.out.println("全查商品分类="+proType);
		JSONArray jsonArray = new JSONArray();
		for(ProType pt:proType) {
			JSONObject jo = new JSONObject();
			jo.put("id", pt.getTypeId());
			jo.put("pId", pt.getParentId());
			jo.put("name", pt.getTypeName()+",id="+pt.getTypeId()+",Pid="+pt.getParentId());
			jo.put("desc", pt.getTypeDesc());
			jo.put("specids", pt.getSpecids());
			jsonArray.add(jo);
		}
		/*for(int i=0;i<jsonArray.size();i++) {
			JSONObject jjo = jsonArray.getJSONObject(i);
			System.out.println("遍历的第"+i+"个JSONObject="+jjo);
		}*/
		//分类信息
		request.setAttribute("proTypeJson", jsonArray);
		//分类特性信息Key
		//System.out.println("特性信息Key="+proTyprService.querySpecification());
		request.getSession().setAttribute("shopTypeSpecIds", proTyprService.querySpecification());
		return "proTypeTree";
	}
	/**
	 * @Title: isTypeName
	 * @Description: 判断分类名是否重复   
	 * @return JSONObject    
	 */
	@RequestMapping("/isTypeName.action")
	@ResponseBody
	public JSONObject isTypeName(String typeName) {
		JSONObject jo = new JSONObject();
		if(proTyprService.isTypeName(typeName)) {//不重复
			jo.put("pd", "Y");
		}else jo.put("pd", "N");//重复
		return jo;
	}
	
	/**
	 * @throws IOException 
	 * @throws ServletException 
	 * @Title: addShopType
	 * @Description: 添加分类   
	 * @return void    
	 */
	@RequestMapping("/addShopType.action")
	public String addShopType(ProType proType,HttpServletRequest request){
		System.out.println("添加的信息="+proType);
		boolean b=proTyprService.addShopType(proType);
		String bsh = "";
		if(b) {//添加失败
			bsh="?identify=7";
		}
		return "redirect:/proType/shopProType.action"+bsh;
	}
	
	/**
	 * @Title: shopTypeId
	 * @Description: 查询当前分类的特性   
	 * @return JSONArray    
	 * @throws
	 */
	@RequestMapping("/shopTypeId.action")
	@ResponseBody
	public JSONArray shopTypeId(String typeId) {
		return proTyprService.shopTypeSpcId(typeId);
	}
	/**
	 * @throws IOException 
	 * @throws ServletException 
	 * @Title: updateShopType
	 * @Description: 更新分类   
	 * @return void    
	 * @throws
	 */
	@RequestMapping("/updateShopType.action")
	public String updateShopType(ProType proType) throws ServletException, IOException {
		//System.out.println("更新的信息="+proType);
		String bsh = "";
		if(proTyprService.updateShopType(proType)) {//更新失败
			bsh="?identify=5";
		}
		return "redirect:/proType/shopProType.action"+bsh;
	}
	
	/**
	 * @Title: deleteShopType
	 * @Description: 删除分类   
	 * @return void    
	 * @throws
	 */

	@RequestMapping("/deleteShopType.action")
	public String deleteShopType(String typeId) {
		System.out.println("删除的id="+typeId);
		String bsh = "";
		if(proTyprService.deleteShopType(typeId)) {//删除失败
			bsh="?identify=1";
		}
		return "redirect:/proType/shopProType.action"+bsh;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	

}
