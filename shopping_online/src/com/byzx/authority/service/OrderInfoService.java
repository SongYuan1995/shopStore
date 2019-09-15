package com.byzx.authority.service;

import java.util.List;
import java.util.Map;

import com.byzx.authority.vo.Address;
import com.byzx.authority.vo.DeliverList;
import com.byzx.authority.vo.Invoice;
import com.byzx.authority.vo.OrderInfo;
import com.byzx.authority.vo.OrderItem;
import com.byzx.authority.vo.ShopStore;

public interface OrderInfoService {
	/**
	* @author zhujiachao
	* @date 2019年8月9日
	* @version 1.0 
	*/
	//查询订单  分页
 public List<OrderInfo> findOrder(Map<String, Object> map);
 
 
//查询订单状态有哪些
	 public List<OrderInfo> findorderstate();
	//查询支付方式有哪些
	 public List<OrderInfo> findpayway();
	 //查询超时订单
	 public Integer uptiming (OrderInfo orderinfo);
	 //查询订单详情 分页
	 public List <OrderItem> fandorderitem(Map<String, Object> map);
	 
	 //查询超时订单
	 public List<OrderInfo> timing();
	//查询订单收货地址
	 public Address findadd(Integer orderid);
	//查询开票信息
	 public Invoice findinvoice(Integer orderid);
	//修改开票审核
	 public Integer upInvoice(Invoice invoice);
	 
	//查询发货
	 public DeliverList finddeliver(Integer orderid);
	//修改发货单
	 public Integer updeliver(DeliverList deliver);
	 
	//查询全部店铺
	 public List<ShopStore> findshop(Map<String, Object> map);
}
