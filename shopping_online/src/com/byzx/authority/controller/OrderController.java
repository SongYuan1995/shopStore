package com.byzx.authority.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.byzx.authority.service.OrderInfoService;
import com.byzx.authority.service.impl.OrderInfoServiceImpl;
import com.byzx.authority.vo.Address;
import com.byzx.authority.vo.DeliverList;
import com.byzx.authority.vo.Invoice;
import com.byzx.authority.vo.OrderInfo;
import com.byzx.authority.vo.OrderItem;
import com.byzx.authority.vo.PageUtil;
import com.byzx.authority.vo.ShopStore;
import com.byzx.authority.vo.UserInfo;


/**
* @author zhujiachao
* @date 2019年8月8日
* @version 1.0 
*/
/**
* @author zhujiachao
* @date 2019年8月14日
* @version 1.0 
*/
@Controller
@RequestMapping("/order")
public class OrderController {
	@Autowired
	private OrderInfoService orderInfoService;
	
	/*
	 * 管理员查看店铺
	 */
	@RequestMapping("/shoplist.action")
	public String shoplist(ShopStore shop, HttpServletRequest request, HttpServletResponse response) {
		String ccc=shop.getStoreName();
		request.getSession().setAttribute("shopps",ccc);
		if(ccc==null) {
			ccc=null;
		}else {
			ccc="%"+ccc+"%";
		}
		shop.setStoreName(ccc);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("shop", shop);
		map.put("page", null);
		List<ShopStore> shsize = orderInfoService.findshop(map);
		request.getSession().setAttribute("shop",shop);
		request.getSession().setAttribute("TOTALNUM",shsize.size());
		return"redirect:/order/shoppage.action?pageNum=1";
	}
	/*
	 * 店铺分页
	 */
	@RequestMapping("/shoppage.action")
	public String shoplist(Integer pageNum,HttpServletRequest request, HttpServletResponse response) {
		pageNum =pageNum==null?1:pageNum;
		PageUtil PageUtil = new PageUtil(6,pageNum);
		HttpSession session = request.getSession();
		Integer totalNum=(Integer) session.getAttribute("TOTALNUM"); //总条数
		ShopStore shopstore = (ShopStore)session.getAttribute("shop");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("shop", shopstore);
		map.put("page", PageUtil);
		List<ShopStore> resultList = orderInfoService.findshop(map);
		PageUtil pageUtil2 = new PageUtil(6,totalNum, pageNum,resultList,"order/shoppage.action",null);
		request.getSession().setAttribute("page",pageUtil2);
		return "order-shopp";
	}
	
	/*
	 * 判断用户权限
	 */
	@RequestMapping("/Orderqu.action")
	public String Orderqu(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		UserInfo userInfo = (UserInfo)session.getAttribute("USER");
		System.out.println(userInfo.getUserType());
		if(userInfo.getUserType().equals("0")) {
			return "redirect:/order/shoplist.action";
		}
		return"redirect:/order/list.action";
	}
	
	
	
	
	@RequestMapping("/list.action")
	public String OrderList(Integer stid,OrderInfo orderinfo,HttpServletRequest request, HttpServletResponse response) throws IOException{
		HttpSession session = request.getSession();
		UserInfo userInfo = (UserInfo)session.getAttribute("USER");
		Integer storeid=null;
		if(userInfo.getUserType().equals("0")) {
			storeid=stid;
		}else {
			storeid=userInfo.getStoreId();
		}
		List<OrderInfo> state= orderInfoService.findorderstate();			//查询有多少状态
		List<OrderInfo> payway=  orderInfoService.findpayway();				//查询有多少支付方式
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("state", state);
		maps.put("payway", payway);
		request.getSession().setAttribute("stapay",maps);
		request.getSession().setAttribute("rderNum",orderinfo.getOrderNum());
		String ccc=orderinfo.getOrderNum();
		if(ccc==null) {
			ccc=null;
		}else {
			ccc="%"+ccc+"%";
		}
		orderinfo.setOrderNum(ccc);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("order",orderinfo);
		map.put("storeid",storeid);
		map.put("page", null);
		List<OrderInfo> cc= orderInfoService.findOrder(map);
		request.getSession().setAttribute("orderss",orderinfo);
		request.getSession().setAttribute("storeid",storeid);
		request.getSession().setAttribute("TOTALNUM",cc.size());
		return "redirect:/order/orderpage.action?pageNum=1";
	}
	
	
	/**
	 * 订单分页
	 * @param pageNum
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/orderpage.action")						
	public void orderpage(Integer pageNum, HttpServletRequest request, HttpServletResponse response) throws IOException{		
		pageNum =pageNum==null?1:pageNum;
		PageUtil PageUtil = new PageUtil(6,pageNum);
		HttpSession session = request.getSession();
		Integer totalNum=(Integer) session.getAttribute("TOTALNUM"); //总条数
		Integer storeid = (Integer) session.getAttribute("storeid");
		OrderInfo orderinfo = (OrderInfo)session.getAttribute("orderss");

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("order",orderinfo);
		map.put("storeid",storeid);
		map.put("page", PageUtil);
		
		List<OrderInfo> resultList= orderInfoService.findOrder(map);
		
		/*
		 * 查询选择开票的订单
		 */
		for (OrderInfo orderInfo2 : resultList) {
			Invoice invo = orderInfoService.findinvoice(orderInfo2.getOrderId());
			orderInfo2.setInvoice(invo);
		}
		PageUtil pageUtil2 = new PageUtil(6,totalNum, pageNum,resultList,"order/orderpage.action",null);
		request.getSession().setAttribute("page",pageUtil2);
		PrintWriter out = response.getWriter();
		out.print("<script>location='../pages/order-list.jsp';</script>");
	}
	
	
	
	
	
	
	/**
	 * 订单详情
	 * @param oItem
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/Itemlist")
	public void OrderItems(OrderItem oItem ,HttpServletRequest request, HttpServletResponse response) throws IOException{
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("orderid",oItem.getOrderId());
		map.put("page", null);
		List<OrderItem> cc= orderInfoService.fandorderitem(map);
		request.getSession().setAttribute("TOTAItmLNUM",cc.size());
		request.getSession().setAttribute("OrderItm",oItem);
		Address address=orderInfoService.findadd(oItem.getOrderId());
		request.getSession().setAttribute("Address",address);
		orderItempage(1, request, response);
	}
	
	
	/**
	 * 订单详情分页
	 * @param pageNum
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("/orderItempage.action")						
	public void orderItempage(Integer pageNum, HttpServletRequest request, HttpServletResponse response) throws IOException{		
		pageNum =pageNum==null?1:pageNum;
		PageUtil PageUtil = new PageUtil(5,pageNum);
		HttpSession session = request.getSession();
		Integer totalNum=(Integer) session.getAttribute("TOTAItmLNUM"); 
		OrderItem orderitem = (OrderItem)session.getAttribute("OrderItm");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("orderid",orderitem.getOrderId());
		map.put("page", PageUtil);
		
		List<OrderItem> resultList= orderInfoService.fandorderitem(map);	
		PageUtil pageUtil2 = new PageUtil(5,totalNum, pageNum,resultList,"order/orderItempage.action",null);
		request.getSession().setAttribute("page",pageUtil2);
		PrintWriter out = response.getWriter();
		out.print("<script>location='../pages/order-item.jsp';</script>");
	}
	
	
	
		/**
		 * 
		 * 导出订单信息
		 * @param request
		 * @return json
		 */
		@RequestMapping("/exportUserInfo.action")
		@ResponseBody
		public JSONObject exportUserInfo(HttpServletRequest request, HttpServletResponse response) {
			HttpSession session = request.getSession();
			UserInfo userInfo = (UserInfo)session.getAttribute("USER");
			OrderInfo orderinfo = (OrderInfo)session.getAttribute("orderss");
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("order",orderinfo);
			map.put("storeid",userInfo.getStoreId());
			map.put("page", null);
			List<OrderInfo> resultList= orderInfoService.findOrder(map);
			request.getSession().setAttribute("page",resultList);
			String i="1";
			JSONObject json = new JSONObject();
			json.put("EXPORT_MSG",i);
			return json;
		}
	
	
		
		/**
		 * 查询选择开票的详情
		 * @param invoice
		 * @return	json
		 */
		@RequestMapping("/invoice.action")
		@ResponseBody
		public JSONObject invoice(Integer orderId, HttpServletRequest request, HttpServletResponse response) {
			OrderInfo Infos=new OrderInfo();
			HttpSession session = request.getSession();
			PageUtil pageUtil2=(PageUtil) session.getAttribute("page"); 
			List<?> order = pageUtil2.getResultList();
			for (Object orders : order) {
				OrderInfo info = (OrderInfo) orders;
				if(info.getOrderId()==orderId) {
					Infos=info;
				}
			}
			JSONObject json = new JSONObject();
			json.put("Invoice", Infos.getInvoice());
			return json;
		}	
		/*
		 * 更改开票状态
		 */
		@RequestMapping("/upvoice.action")			
		public String upvoice(Integer orderId, HttpServletRequest request, HttpServletResponse response) {
			Invoice invoice = new Invoice();
			invoice.setOrderId(orderId);
			invoice.setState("1");
			orderInfoService.upInvoice(invoice);
			HttpSession session = request.getSession();
			PageUtil sRand=(PageUtil)session.getAttribute("page");
			return "redirect:/order/orderpage.action?pageNum="+sRand.getPageNum();
		}	
		
		/*
		 * 查询发货单
		 */
		@RequestMapping("/deliver.action")
		@ResponseBody
		public JSONObject deliver(Integer orderId, HttpServletRequest request, HttpServletResponse response) {
			JSONObject json = new JSONObject();
			json.put("deliver",orderInfoService.finddeliver(orderId));
			return json;
		}	
		/*
		 * 更改发货状态
		 */
		@RequestMapping("/updeliver.action")			
		public String updeliver(DeliverList deliver, HttpServletRequest request, HttpServletResponse response) {
			deliver.setState("1");
			System.out.println(deliver);
			orderInfoService.updeliver(deliver);
			HttpSession session = request.getSession();
			PageUtil sRand=(PageUtil)session.getAttribute("page");
			return "redirect:/order/orderpage.action?pageNum="+sRand.getPageNum();
			}

}