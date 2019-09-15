package com.byzx.authority.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.byzx.authority.service.OrderInfoService;
import com.byzx.authority.vo.OrderInfo;

public class QuartzCron{
	@Autowired
	private OrderInfoService orderInfoService;
	
	public void run1(){
		System.out.println("开始");
		List<OrderInfo> order = orderInfoService.timing();
		for (OrderInfo orderInfo : order) {
			System.out.println(orderInfo);
			orderInfo.setOrderState("-1");
		orderInfoService.uptiming(orderInfo);
		}
	}

}
