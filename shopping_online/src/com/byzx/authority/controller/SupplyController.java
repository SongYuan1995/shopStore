package com.byzx.authority.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.byzx.authority.service.SupplyService;
import com.byzx.authority.vo.PageUtil;
import com.byzx.authority.vo.Supply;



@Controller
@RequestMapping("/Supply")
public class SupplyController {

	@Autowired
	private SupplyService  supplyService;
/**
 * @param request
 * @param response
 * @param supply
 * @return
 */
	
	@RequestMapping("/findAllSupply.action")
	public ModelAndView findAllSupply(HttpServletRequest request,HttpServletResponse response,Supply supply){
		System.err.println("进来这里啊");
		
		StringBuffer params=new StringBuffer();
		   //每页显示条数
		 String pageNum = request.getParameter("pageNum");
		 Integer pageLimit=5;
		 if(StringUtils.isNotBlank(pageNum)){
			  pageLimit=Integer.parseInt(pageNum);
		 } 
		  //当前页 
		  String currNo= request.getParameter("currNo");
		  Integer  currPage=1;
		  if(StringUtils.isNotBlank(currNo)){
			  currPage=Integer.parseInt(currNo);
		  }
		  
		  //获取模糊查询用户名,并拼接
		  if(StringUtils.isNotBlank(supply.getSupplyName())){
		    	params.append("&supplyName=").append(supply.getSupplyName());
		    }
		  Map<String,Object> map=new HashMap<String,Object>();
		    map.put("supply", supply);
		    //查询数量
		    Integer totalCount = supplyService.getSupplyCount(map);
		    //分页查询
		    PageUtil page= new PageUtil(pageLimit, currPage);
		    map.put("page", page);
		    List<Supply> resultList= supplyService.findAllSupply(map);		  
	
		    
		    page=new PageUtil(pageLimit,totalCount,currPage,resultList,"/Supply/findAllSupply.action",params);
		    ModelAndView mav = new ModelAndView();
			mav.addObject("page", page);	
			mav.setViewName("Supply-list");
		    return mav;
	}
	/**
	 * 
	 * @param supply
	 * @return
	 */
	@RequestMapping("/addSupply.action")
	@ResponseBody
	public JSONObject  addSupply(Supply supply){
		//根据添加用户组code 判断是否存在，null表示可以添加，存在code已存在
    	String supplyName=supplyService.findSupplyBySupplyName(supply);
    	JSONObject json=new JSONObject();
    	if(supplyName==null||supplyName.equals("")){
    	    Integer num= supplyService.insertsupply(supply);
    	    if(num>0){
    	    	json.put("re", "1");//表示添加成功
    	    }else{
    	    	json.put("re", "0");//表示添加失败
    	    }
    	}else{
    		json.put("re", "-1");//表示用供货商名称已存在
    	}   	
    	return json;		
	}	
	@RequestMapping("/findAllSupplyBysupplyNum.action")
	@ResponseBody
	public JSONObject findAllSupplyBysupplyNum(Supply supply){
		String placeNum=supplyService.findAllSupplyBysupplyNum(supply);
		JSONObject  jsonObject=new JSONObject();
		if(placeNum==null||placeNum.equals("")){
			jsonObject.put("ree", "1");
		}else{
			jsonObject.put("ree", "0");
		}
		return jsonObject;
	}
	/**
	 * 
	 * @param supply
	 * @return
	 */
	@RequestMapping("/updataAllSupply.action")
	@ResponseBody
	public JSONObject updataAllSupply(Supply supply){
		
			   Integer num=supplyService.updataAllSupply(supply);
			   JSONObject json=new JSONObject();
			   if(num>0){
				   json.put("re", "1");//1修改成功
			   }else{
				   json.put("re", "0");//0修改失败
			   }
			   return json;
	}
	/**
	 * 
	 * @param supplyId
	 * @return
	 */
	@RequestMapping("/deleteSupply.action")
	@ResponseBody
	 public JSONObject deleteSupply(@RequestParam(value="supplyId",required=false)String supplyId){
	   	   //调用逻辑删除方法
   Integer num= supplyService.deleteSupply(Integer.parseInt(supplyId));
   JSONObject json=new JSONObject();
   if(num>0){
	   json.put("re", "1");//1删除成功
   }else{
	   json.put("re", "0");//0删除失败
   }
   return json;
}
	/**
	 * @return
	 */
	@RequestMapping("/findProSupplyList.action")
	@ResponseBody
	public List<Supply> findProSupplyList(){
		List<Supply> list = supplyService.findProSupplyList();
		
		return list;
	}
}
