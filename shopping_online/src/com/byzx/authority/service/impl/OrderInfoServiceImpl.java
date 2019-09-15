package com.byzx.authority.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.byzx.authority.dao.OrderInfoMapper;
import com.byzx.authority.service.OrderInfoService;
import com.byzx.authority.vo.Address;
import com.byzx.authority.vo.DeliverList;
import com.byzx.authority.vo.Invoice;
import com.byzx.authority.vo.OrderInfo;
import com.byzx.authority.vo.OrderItem;
import com.byzx.authority.vo.ShopStore;

@Service
public class OrderInfoServiceImpl implements OrderInfoService {

	@Autowired
	private OrderInfoMapper orderinfomapper;

	/***
	 *查询订单  分页
	 */
	@Override
	public List<OrderInfo> findOrder(Map<String, Object> map) {
		List<OrderInfo> cc = orderinfomapper.findOrder(map);
		return cc;
	}

	/***
	 * 查询订单详情 分页
	 */
	@Override
	public List<OrderItem> fandorderitem(Map<String, Object> map) {
		return orderinfomapper.fandorderitem(map);
	}


	
	/***
	 * 查询订单状态有哪些
	 */
	@Override
	public List<OrderInfo> findorderstate() {
		return orderinfomapper.findorderstate();
	}
	/***
	 * 查询支付方式有哪些
	 */
	@Override
	public List<OrderInfo> findpayway() {
		return orderinfomapper.findpayway();
	}

	
	/***
	 * 查询超时订单
	 */
	@Override
	public List<OrderInfo> timing() {
		return orderinfomapper.timing();
	}

	/***
	 * 查询订单收货地址
	 */
	@Override
	public Address findadd(Integer orderid) {
		return orderinfomapper.findadd(orderid);
	}

	/***
	 * 查询开票信息
	 */
	@Override
	public Invoice findinvoice(Integer orderid) {
		// TODO Auto-generated method stub
		return orderinfomapper.findinvoice(orderid);
	}
	/***
	 * 修改开票审核
	 */
	@Override
	public Integer upInvoice(Invoice invoice) {
		// TODO Auto-generated method stub
		return orderinfomapper.upInvoice(invoice);
	}



	/***
	 * 修改超时订单状态
	 */
	@Override
	public Integer uptiming(OrderInfo orderinfo) {
		
		return orderinfomapper.uptiming(orderinfo);
	}

	/***
	 * 询发货
	 */
	@Override
	public DeliverList finddeliver(Integer orderid) {
		// TODO Auto-generated method stub
		return orderinfomapper.finddeliver(orderid);
	}

	/***
	 * 修改发货单
	 */
	@Override
	public Integer updeliver(DeliverList deliver) {
		// TODO Auto-generated method stub
		return orderinfomapper.updeliver(deliver);
	}

	/***
	 * 查询全部店铺
	 */
	@Override
	public List<ShopStore> findshop(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderinfomapper.findshop(map);
	}


	

	




}
