package com.byzx.authority.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.byzx.authority.service.AuthInfoService;
import com.byzx.authority.service.UserInfoService;
import com.byzx.authority.vo.AuthInfo;
import com.byzx.authority.vo.PageUtil;
import com.byzx.authority.vo.Role;
import com.byzx.authority.vo.UserGroup;
import com.byzx.authority.vo.UserInfo;

@Controller
@RequestMapping("/user")
public class AuthInfoController {
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private AuthInfoService authInfoService;
	@RequestMapping("/index.action")
	@ResponseBody						//jQuer中的Ajax注解
	public void userIndex(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("###已经进入首页面的后台***" );
		//userId groupId authId
		//获取userId 
		UserInfo userInfo = (UserInfo)request.getSession().getAttribute("USER_INFO");
		userInfo.getUserId();
		userInfo.getGroupId();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userId",userInfo.getUserId());
		map.put("groupId",userInfo.getGroupId());
		map.put("authId",0);
		//所有的一级权限
		List<AuthInfo> fisrstAuths = authInfoService.findAuthority(map);
		System.err.println(fisrstAuths);
		for(AuthInfo auth:fisrstAuths) {
			Integer authId = auth.getAuthId();
			map.put("authId", authId);
			List<AuthInfo> secondtAuths = authInfoService.findAuthority(map);
			auth.setChildList(secondtAuths);
		}
		request.getSession().setAttribute("firstList", fisrstAuths);
		PrintWriter out = response.getWriter();
		out.println("<script>location.href='../pages/index.jsp';</script>");
	}
	//展示用户信息的后台
	@RequestMapping("/list.action")
	@ResponseBody						
	public void listUser(String userCode,String userType,String userState,String identity,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**已经进入首页面列表页面后台***" );
		
		System.err.println("**已经进入模糊搜索fuzzyQuery后台***" );
		System.err.println("点击模糊搜索按钮后出传过来的userName为："+userCode );
		System.err.println("点击模糊搜索按钮后出传过来的userType为："+userType );
		System.err.println("点击模糊搜索按钮后出传过来的userState为："+userState );
		System.err.println("点击模糊搜索按钮后出传过来的identity为："+identity );
		HttpSession session = request.getSession();
		session.setAttribute("userName", userCode);
		session.setAttribute("userType", userType);
		session.setAttribute("userState", userState);
		//根据页面传过来的用户类型的字，去数据库查role表中对应的role_id;
		Role role = authInfoService.findIdByRoleName(userType);
		String userType1="";
		//判断页面传过来的用户状态的值，将汉字转为数字代号
		if(null!=role) {
			 userType1 = role.getRoleId().toString();
			 }
		userState=null==userState?"":userState;
		if(userState.equals("启用")) {
			userState="1";
		}else if(userState.equals("禁用")) {
			userState="0";
		}else if(userState.equals("全部")) {
			userState=null;
		}
		
		System.err.println(userType1);
		UserInfo userInfo = new UserInfo(userCode, userType1, userState);
		//将查到的用户对象存在session中
		session.setAttribute("USER_OBJ", userInfo);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userInfo", userInfo);
		map.put("page", null);
		List<UserInfo> userinfos = authInfoService.findAllUserInfo(map);
		//存共有多少条信息
		request.getSession().setAttribute("ULIST",userinfos.size());
		//查询用户角色
		List<Role> roles = authInfoService.findAllRole();
		//查询用户组
		List<UserGroup> userGroup = userInfoService.findAllUserGroup();
		System.err.println("查出的角色为"+roles);
		session.setAttribute("ROLES", roles);
		session.setAttribute("USER_GROUP", userGroup);
		//跳转后台
		Integer pageNum =(Integer)session.getAttribute("PAGE_NUM");
		AuthInfoController.this.lists(pageNum,request, response);
	}	
	@RequestMapping("sts.action")
	@ResponseBody
	public void lists(Integer pageNum, HttpServletRequest request, HttpServletResponse response) throws IOException{
		pageNum =pageNum==null?1:pageNum;
		//将pegeNum存起来
		HttpSession session = request.getSession();
		session.setAttribute("PAGE_NUM", pageNum);
		//第一个参数为每页显示几条数据
		//第二个参数为当前为第几页
		PageUtil PageUtil = new PageUtil(5,pageNum);
		UserInfo userInfo =(UserInfo) session.getAttribute("USER_OBJ");
		//取出存的共几条数据
		Integer totalNum=(Integer) session.getAttribute("ULIST");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userInfo", userInfo);
		map.put("page", PageUtil);
		List<UserInfo> ulist = authInfoService.findAllUserInfo(map);//全查用户表
		PageUtil pageUtil2 = new PageUtil(5,totalNum, pageNum,ulist,"user/sts.action",null);
		request.getSession().setAttribute("page",pageUtil2);
		PrintWriter out = response.getWriter();
		out.print("<script>location.href='../pages/user-list.jsp';</script>");	
	
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*@RequestMapping("/fuzzyQuery.action")
	@ResponseBody						
	public void fuzzyQuery(String userName,String userType,String userState,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**已经进入模糊搜索fuzzyQuery后台***" );
		System.err.println("点击模糊搜索按钮后出传过来的userName为："+userName );
		System.err.println("点击模糊搜索按钮后出传过来的userType为："+userType );
		System.err.println("点击模糊搜索按钮后出传过来的userState为："+userState );
		Role role = authInfoService.findIdByRoleName(userType);
		String userType1="";
		//判断页面传过来的用户状态的值，将汉字转为数字代号
		if(null!=role) {
		 userType1 = role.getRoleId().toString();
		 }
		if(userState.equals("启用")) {
			userState="1";
		}else if(userState.equals("禁用")) {
			userState="0";
		}
		System.err.println(userType1);
		UserInfo userInfo = new UserInfo(userName, userType1, userState);
		ParameterTypeQuery ptq = new ParameterTypeQuery();
		ptq.setUserInfo(userInfo);
		List<UserInfo> userinfos = userInfoService.findUserFuzzy(ptq);
		for(UserInfo userinfo:userinfos) {
			System.err.println(userinfo);
		}
		request.getSession().setAttribute("roles", userinfos);
		PrintWriter out = response.getWriter();
		out.println("<script>location.href='../pages/user-list.jsp';</script>");
		
	}	*/
	
	/*List<UserInfo> users = authInfoService.findAllUserInfo();
	HttpSession session = request.getSession();
	session.setAttribute("roles", users);
	List<Role> roles = authInfoService.findAllRole();
	System.err.println("查出的角色为"+roles);
	session.setAttribute("ROLES", roles);
	PrintWriter out = response.getWriter();
	out.println("<script>location.href='../pages/user-list.jsp';</script>");*/
	
	
	
	//查用户类型对应的代号的后台
	
		/*@RequestMapping("/userType.action")
		@ResponseBody	
		public JSONObject userType(String userType,HttpServletRequest request, HttpServletResponse response) {
			
			System.err.println("登录页面传过来的验证码为:" + userType);
			//获取session对象
			HttpSession session = request.getSession();
			//从session中取出验证码
			
			Integer i=0;
			if(null!=vCode && conCode.equals(vCode)) {
				i=1;
			}else{
				i=2;
			}
			//new JSON 对象
			JSONObject data = new JSONObject();
			data.put("msg",i);
			System.err.println(data);
			return data;
		}*/
		
	
		
	

}
