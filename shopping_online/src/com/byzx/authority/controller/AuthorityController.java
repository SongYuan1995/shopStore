package com.byzx.authority.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.byzx.authority.service.AuthInfoService;
import com.byzx.authority.service.UserInfoService;
import com.byzx.authority.vo.AuthInfo;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/auth")
public class AuthorityController {
	@Autowired
	private AuthInfoService authInfoService;
	@Autowired
	private UserInfoService userInfoService;
	
	@RequestMapping("/list.action")
	@ResponseBody
	public void listUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**已经进入权限管理的权限树页面的后台***" );
		//全查auth_info表
		List<AuthInfo> authInfos = userInfoService.findAllAuthInfo();
		//new JSONArray[{},{},{}.....]和JSONObject{}
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		//遍历所有的权限
		for(AuthInfo authInfo:authInfos){
			//{ id:1, pId:0, name:"名称", open:false},
			jsonObject.put("id", authInfo.getAuthId());
			jsonObject.put("pId", authInfo.getParentId());
			jsonObject.put("name", authInfo.getAuthName());
			jsonObject.put("state", authInfo.getAuthState());
			jsonObject.put("desc", authInfo.getAuthDesc());
			jsonObject.put("authGrade", authInfo.getAuthGrade());
			System.err.println("当前权限"+authInfo);
			jsonArray.add(jsonObject);
		}
		request.getSession().setAttribute("JSON_ARRAY", jsonArray);
		PrintWriter out = response.getWriter();
		out.println("<script>location.href='../pages/authTree.jsp';</script>");
	}
	//权限名称的唯一性验证
	@RequestMapping("/checkAuthNameIsExist.action")
	@ResponseBody
	public JSONObject checkAuthNameIsExist( String authName,Integer parentId,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**权限名称的唯一性验证的后台***"+authName);
		System.err.println("**权限名称的唯一性验证的权限的父Id为：***"+parentId);
		//将父id存起来
		request.getSession().setAttribute("PARENT_ID", parentId);
		//判断当前级别下的，权限是否已近存在
		String returnMsg="";
		if(authInfoService.isExistInputAuth(authName, parentId)) {
			returnMsg="1";
		}else {
			returnMsg="2";
		}
		JSONObject json = new JSONObject();
		json.put("MSG", returnMsg);
		return json;
	}
	//权限Code的唯一性验证
	@RequestMapping("/checkAuthCodeIsExist.action")
	@ResponseBody
	public JSONObject checkAuthCodeIsExist( String authCode,Integer parentId,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**权限Code的唯一性验证的后台***"+authCode);
		//判断当前级别下的，权限是否已近存在
		String returnMsg="";
		if(authInfoService.isExistAuthCode(authCode)) {
			returnMsg="1";
		}else {
			returnMsg="2";
		}
		JSONObject json = new JSONObject();
		json.put("MSG", returnMsg);
		return json;
	}
	//判断URL的唯一
	@RequestMapping("/checkAuthURLIsExist.action")
	@ResponseBody
	public JSONObject checkAuthURLIsExist( String authUrl,Integer parentId,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**权限Code的唯一性验证的后台***"+authUrl);
		//判断当前级别下的，权限是否已近存在
		String returnMsg="";
		if(authInfoService.isExistAuthURL(authUrl)) {
			returnMsg="1";
		}else {
			returnMsg="2";
		}
		JSONObject json = new JSONObject();
		json.put("MSG", returnMsg);
		return json;
	}
	//点击添加按钮进入的后台
	@RequestMapping("/addNewAuth.action")
	@ResponseBody
	public void addNewAuth(AuthInfo authInfo,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**点击添加按钮进入的后台parentId：" +authInfo.getParentId());
		System.err.println("**点击添加按钮进入的后台AuthName：" +authInfo.getAuthName());
		System.err.println("**点击添加按钮进入的后台authUrl*"+ authInfo.getAuthUrl());
		System.err.println("**点击添加按钮进入的后台authCode*"+authInfo.getAuthCode() );
		System.err.println("**点击添加按钮进入的后台*authDesc"+authInfo.getAuthDesc() );
		System.err.println("**点击添加按钮进入的后台*authGrade"+authInfo.getAuthGrade() );
		Integer parentId = (Integer)request.getSession().getAttribute("PARENT_ID");
		String authType=authInfo.getAuthGrade().toString();
		authInfo.setParentId(parentId);
		authInfo.setAuthType(authType);
		//添加
		authInfoService.insertSelectiveAuth(authInfo);
		PrintWriter out = response.getWriter();
		out.println("<script>alert('权限添加成功！');location.href='../auth/list.action';</script>");
	}
	//修改时的权限名称的唯一性验证
	@RequestMapping("/changeAuthNameIsExist.action")
	@ResponseBody
	public JSONObject changeAuthNameIsExist( String authName,Integer authId,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**权限名称的唯一性验证的后台***"+authName);
		System.err.println("**权限名称的唯一性验证的权限的Id为：***"+authId);
		//用当前权限的id查询当前权限的父id
		AuthInfo authInfo = authInfoService.finndAuthInfoById(authId);
		Integer parentId = authInfo.getParentId();
		System.err.println("权限id为："+authId+",的父Id为："+parentId);
		//判断当前级别的，权限是否已近存在
		String returnMsg="";
		if(authInfoService.isExistInputAuth(authName, parentId)) {
			returnMsg="1";
		}else {
			returnMsg="2";
		}
		JSONObject json = new JSONObject();
		json.put("MSG", returnMsg);
		return json;
	}
	//点击修改按钮进入的后台
	@RequestMapping("/ChangeOldAuth.action")
	@ResponseBody
	public void ChangeOldAuth(AuthInfo authInfo,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**点击添加按钮进入的后台parentId：" +authInfo.getAuthId());
		System.err.println("**点击添加按钮进入的后台AuthName：" +authInfo.getAuthName());
		System.err.println("**点击添加按钮进入的后台*authDesc"+authInfo.getAuthDesc() );
		authInfoService.updateThisAuth(authInfo);	
	//修改
	PrintWriter out = response.getWriter();
	out.println("<script>alert('权限修改成功！');location.href='../auth/list.action';</script>");
	}
	//删除权限deleteAuth.action
	@RequestMapping("/deleteAuth.action")
	@ResponseBody
	public void deleteAuth(Integer authId,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**删除权限时的时后台authId：" +authId);
		AuthInfo authInfo = new AuthInfo();
		authInfo.setAuthId(authId);
		authInfoService.deleteThisAuth(authInfo);
		PrintWriter out = response.getWriter();
		out.println("<script>alert('权限修改成功！');location.href='../auth/list.action';</script>");
	}
	//恢复权限
	@RequestMapping("/reinAuth.action")
	@ResponseBody
	public void reinAuth(Integer authId,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**修改权限时的时后台authId：" +authId);
		PrintWriter out = response.getWriter();
		AuthInfo authInfo = new AuthInfo();
		authInfo.setAuthId(authId);
		if(authInfoService.regainThisAuth(authInfo)) {
			out.println("<script>alert('权限恢复失败！');location.href='../auth/list.action';</script>");
			return;
		}
		out.println("<script>alert('权限恢复成功！');location.href='../auth/list.action';</script>");
	}
	
	
	
	
	
	
	
}
