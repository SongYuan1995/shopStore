package com.byzx.authority.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.byzx.authority.service.AuthInfoService;
import com.byzx.authority.service.UserInfoService;
import com.byzx.authority.vo.AuthInfo;
import com.byzx.authority.vo.ParameterTypeQuery;
import com.byzx.authority.vo.Role;
import com.byzx.authority.vo.UserAuth;
import com.byzx.authority.vo.UserGroup;
import com.byzx.authority.vo.UserInfo;
import com.byzx.authority.vo.UserRole;

import net.sf.json.JSONArray;


@Controller
@RequestMapping("/user")
public class UserInfoController {
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private AuthInfoService authInfoService;
	//${pageContext.request.contextPath}
	
	//异步请求页面传过来的验证码的验证
	@RequestMapping("/userInputCode.action")
	@ResponseBody
	public JSONObject userInputCode(String vCode,HttpServletRequest request, HttpServletResponse response) {
		System.err.println("登录页面传过来的验证码为:" + vCode);
		//获取session对象
		HttpSession session = request.getSession();
		//从session中取出验证码
		String conCode = (String)session.getAttribute("SRAND");
		System.err.println("session中取出来的conCode为:" + conCode);
		//取出来的验证码和页面传过来的验证码是否一致一致返回1，不一致返回2
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
	}
	//用户点击登录按钮时，跳向的后台！
	@RequestMapping("/login.action")
	@ResponseBody					//jQuer中的Ajax注解
	public JSONObject userLogin(String userCode,String userPwd, String vCode,HttpServletRequest request, HttpServletResponse response) {
		System.err.println("登录页面传过来的用户名为:" + userCode);
		System.err.println("登录页面传过来的密码为:" + userPwd);
		System.err.println("登录页面传过来的验证码为:" + vCode);
		//获取session对象
		HttpSession session = request.getSession();

		
		//全查role表，为分配角色提供数据
		List<Role> roles = userInfoService.findAssignAllRoles();
		//System.err.println("所有的用户角色信息"+roles);
		session.setAttribute("assignUserRoles",roles);
		
		//从session中取出验证码
		String conCode = (String)session.getAttribute("SRAND");
		System.err.println("session中取出来的conCode为:" + conCode);
		//new ParameterTypeQuery 对象
		ParameterTypeQuery ptq = new ParameterTypeQuery();
		UserInfo userInfo = new UserInfo();
		userInfo.setUserCode(userCode);
		userInfo.setUserPwd(userPwd);
		ptq.setUserInfo(userInfo);
		//调用session的方法判断用户名和密码是否正确
		Integer i=0;
		if(userInfoService.isRightUser(ptq) && null!=vCode && conCode.equals(vCode)) {
			//如果是正确的用户名,密码,验证码
			System.err.println("******用户名，密码，验证码正确*******");
			UserInfo userInfo1 = userInfoService.findUserByCodeAndPwd(ptq);
			request.getSession().setAttribute("USER_INFO", userInfo1);
			i=1;
		}else{
			i=2;
		}
		//new JSON 对象
		JSONObject data = new JSONObject();
		data.put("res",i);
		return data;
	}
	
	//添加用户时,对用户名userCode进行Ajax验证,的后台
	@RequestMapping("/addUserCode.action")
	@ResponseBody
	public JSONObject addUserCode(String userCode,HttpServletRequest request, HttpServletResponse response) {
		System.err.println("添加页面传过来的验证用户名为:" + userCode);
		//获取session对象
		HttpSession session = request.getSession();
		//new ParameterTypeQuery 对象
		ParameterTypeQuery ptq = new ParameterTypeQuery();
		UserInfo userInfo = new UserInfo();
		userInfo.setUserCode(userCode);
		ptq.setUserInfo(userInfo);
		String i="";
		if(userInfoService.hasOrNotUserCode(ptq)) {
			i="1";
		}else {
			i="2";
		}
		//new JSON 对象
		JSONObject json = new JSONObject();
		json.put("MSG",i);
		System.err.println(json);
		return json;
	}
	//点击添加按钮时跳向的后台，添加用户的后台
	@RequestMapping("/addUserInfo.action")
	@ResponseBody
	public void addUserInfo(UserInfo userInfo,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("添加用户页面传过来的userCode为：");
		System.err.println("添加用户页面传过来的userCode为："+userInfo.getUserCode());
		System.err.println("添加用户页面传过来的userName为："+userInfo.getNickName());
		System.err.println("添加用户页面传过来的GroupId为："+userInfo.getUserType());
		System.err.println("添加用户页面传过来的userPwd为："+userInfo.getUserPwd());
		//根据页面传过来的用户类型的字，去数据库查role表中对应的role_id;
		//判断页面传过来的用户组的值，将汉字转为数字代号
		String groupName = userInfo.getUserType();
		UserGroup userGroup= userInfoService.findUserGroupByName(groupName);
		Integer groupId = userGroup.getGroupId();
		userInfo.setGroupId(groupId);
		userInfoService.addUserInfo(userInfo);
		PrintWriter out = response.getWriter();
		out.println("<script>alert('添加成功');location.href='../user/list.action';</script>");
	
	}
	//修改，删除，启用/禁用，重置密码，时,对用户名信息的修改的后台
	@RequestMapping("/updateUserInfo.action")
	@ResponseBody
	public void updateUserInfo(String  userCode,String nickName,String userType,String isDelete,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("修改或者删除页面传过来的验证用户名为:" + userCode);
		System.err.println("修改页面传过来的验证用户昵称为:" + nickName);
		System.err.println("修改页面传过来的验证用户部门为:" + userType);
		System.err.println("删除按钮页面传过来的isDelete为:" + isDelete);
		PrintWriter out = response.getWriter();
		Map<String,Object> map = new HashMap<String,Object>();
		if(null==isDelete) {//修改
			UserGroup  userGroup  = userInfoService.findUserGroupByName(userType);
			Integer  groupId = userGroup.getGroupId();
			//new userInfo对象，设置值
			UserInfo userInfo = new UserInfo();
			userInfo.setUserCode(userCode);
			userInfo.setNickName(nickName);
			userInfo.setGroupId(groupId);
			map.put("userInfo",userInfo);
			userInfoService.updateByPrimaryKeyUserInfo(map);
			out.println("<script>alert('修改成功');location.href='../user/list.action';</script>");
		}else if(isDelete.equals("1")) {//删除
			System.err.println("进入删除的后台");
			UserInfo userInfo = new UserInfo();
			userInfo.setUserCode(userCode);
			userInfo.setIsDelete(isDelete);
			map.put("userInfo",userInfo);
			userInfoService.updateByPrimaryKeyUserInfo(map);
			out.println("<script>alert('删除成功');location.href='../user/list.action';</script>");
		}else if(isDelete.equals("disable") || isDelete.equals("enable") ) {//启用与禁用
			if(isDelete.equals("disable")) {//当前时是禁用状态，点击启用按钮，启用用户
				String userState = "1";
				UserInfo userInfo = new UserInfo();
				userInfo.setUserCode(userCode);
				userInfo.setUserState(userState);
				map.put("userInfo",userInfo);
				userInfoService.updateByPrimaryKeyUserInfo(map);
				out.println("<script>alert('成功启用');location.href='../user/list.action';</script>");
			}else if(isDelete.equals("enable")) {//点击禁用按钮，禁用用户
				String userState = "0";
				UserInfo userInfo = new UserInfo();
				userInfo.setUserCode(userCode);
				userInfo.setUserState(userState);
				map.put("userInfo",userInfo);
				userInfoService.updateByPrimaryKeyUserInfo(map);
				out.println("<script>alert('成功禁用');location.href='../user/list.action';</script>");
			}
		}else if(isDelete.equals("resetPassword")){//点击重置密码按钮
			//重置密码为123456；
			String userPwd = "123456";
			UserInfo userInfo = new UserInfo();
			userInfo.setUserCode(userCode);
			userInfo.setUserPwd(userPwd);
			map.put("userInfo",userInfo);
			userInfoService.updateByPrimaryKeyUserInfo(map);
			out.println("<script>alert('成功重置密码');location.href='../user/list.action';</script>");
			System.err.println("点击重置密码按钮"+userCode+"888888"+userPwd);
		}
	}
	
	//给用户分配角色的后台
	@RequestMapping("/assigningRoles.action")
	@ResponseBody
	public JSONArray assigningRoles(Integer userId,HttpServletRequest request, HttpServletResponse response) {
		System.err.println("给用户分配角色的后台assigningRoles.action"+"用户id"+userId );
		HttpSession session = request.getSession();
		//将传过来的当前用户的id存入session
		session.setAttribute("CURR_USERID", userId);
		//当前用户角色的id字符串，
		String rolesIdStr = userInfoService.findAllRoleIdString(userId);
		//System.err.println("长度"+rolesIdStr.length()+"全查出来的结果为：");
		//用,切割字符串变为字符串数组,用json返回到页面
		JSONArray jsonArray = new JSONArray();
		if(rolesIdStr!=null) {
			String[] rolesIdStringArray = rolesIdStr.split(",");
			for(int i=0;i<rolesIdStringArray.length;i++) {
				jsonArray.add(rolesIdStringArray[i]);
			}
			//session.setAttribute("assignUserRoleId", rolesIdStringArray);
		}
		return jsonArray;
	}
	//点击了给用户分配角色的按钮时进入的后台
	@RequestMapping("/comfirmAssignSubmit.action")
	@ResponseBody
	@Transactional			//用name值接收复选框传过来的value值
	public void comfirmAssignSubmit(Integer[] roleIds, HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("点击了给用户分配角色的按钮时进入的后台comfirmAssignSubmit.action"+"数组为id:"+roleIds );
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		if(null!=roleIds) {
			//从session中取出,传过来的当前用户的id存入
			Integer userId = (Integer)session.getAttribute("CURR_USERID");
			System.err.println("取出来的用户id为："+userId);
			UserRole userRole = new UserRole();
			//删除该用户的所有角色
			userInfoService.deleteThisUserRoles(userId);
			//遍历给该用户添加角色
			for(Integer roleId:roleIds) {
				System.out.println("点击了给用户分配角色的按钮时"+roleId);
				userRole.setRoleId(roleId);
				userRole.setUserId(userId);
				userInfoService.reAssignRoles(userRole);
			}
			
			out.println("<script>alert('成功为该用户发配了角色！');location.href='../user/list.action';</script>");
		}
		out.println("<script>alert('分配角色失败！');location.href='../user/list.action';</script>");
	}
		
	
	//修改权限时，查询当前用户所有的权限
	//一级权限下的二级权限的三级权限，并存为JSONArray的数据形式
	/*var zNodes =[
     { id:1, pId:0, name:"随意勾选 1", open:false},
     { id:11, pId:1, name:"随意勾选 1-1", open:true},
     { id:111, pId:11, name:"随意勾选 1-1-1"},
     { id:112, pId:11, name:"随意勾选 1-1-2",checked:true},
     { id:12, pId:1, name:"随意勾选 1-2", open:true},
     { id:121, pId:12, name:"随意勾选 1-2-1"},
     { id:122, pId:12, name:"随意勾选 1-2-2"},
     ]*/
	@RequestMapping("/userListChangeAuthority.action")
	@ResponseBody						
	public void userListChangeAuthority(Integer userId,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("已经进入修改权限时的后台**传过来的userId="+userId);
		HttpSession session = request.getSession();
		//将传过来的当前用户的id存入session
		session.setAttribute("CURR_USERID", userId);
		//全查auth_info表
		List<AuthInfo> authInfos = userInfoService.findAllAuthInfo();
		//根据用户的的id查询该用户所有的权限id，一级，二级，三级权限
		List<UserAuth> userAuths = userInfoService.findAllAuthIDbyUserId(userId);
		//遍历List<UserAuth>获取当前用户的List<UserAuth>权限的id，将id放在数组中
		List<Integer> userAuthIds = new ArrayList<Integer>();
		for(UserAuth userAuth:userAuths) {
			userAuthIds.add(userAuth.getAuthId());
			System.err.println("用户的权限id为："+userAuth.getAuthId());
		}
		System.err.println("用户的权限id个数"+userAuthIds.size());
		//new JSONArray[{},{},{}.....]和JSONObject{}
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		//遍历所有的权限
		for(AuthInfo authInfo:authInfos){
			//{ id:1, pId:0, name:"名称", open:false},
			jsonObject.put("id", authInfo.getAuthId());
			jsonObject.put("pId", authInfo.getParentId());
			jsonObject.put("name", authInfo.getAuthName());
			//判断，包含在 ，所有权限id中的当前用户的权限的id相等的当前用户权限打钩
			if(userAuthIds.contains(authInfo.getAuthId())) {
				jsonObject.put("checked", true);
			}else {
				jsonObject.put("checked", false);
			}
			
			System.err.println("当前权限"+authInfo);
			jsonArray.add(jsonObject);
		}
		request.getSession().setAttribute("jsonArray", jsonArray);
		PrintWriter out = response.getWriter();
		out.println("<script>location.href='../pages/userListChangeAuthTree.jsp';</script>");
	}
	
	@RequestMapping("/comfirmChangeAssign.action")
	@ResponseBody
	@Transactional	
	public void comfirmChangeAssign(String thisUserAuthIdsStr,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("已经进入修改权限时点击了确认修改权限时**传过来的权限id的字符串为="+thisUserAuthIdsStr);
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		Map<String,Object> map = new HashMap<String,Object>();
		//获取当前用户的id
		Integer userId = (Integer)session.getAttribute("CURR_USERID");
		Integer i=0;
		if(""!=thisUserAuthIdsStr) {
			//删除user_auth表里的id为userId的所有auth_id
			userInfoService.delCurrUserAuthIds(userId);
			//拆分传过来的字符串
			String[] strArrAuthIds = thisUserAuthIdsStr.split(",");
			System.out.println("ids的字符数组为"+strArrAuthIds);
			for(String authId:strArrAuthIds ) {
				map.put("userId", userId);
				map.put("authId", authId);
				i = userInfoService.insertCurrUserAuthId(map);
				i++;
			}
		}
		if(i==0) {
			out.println("<script>alert('权限修改失败！')location.href='${pageContext.request.contextPath}/user/userListChangeAuthority.action?userId="+userId+"';</script>");
		}else if(i>0) {
			out.println("<script>alert('成功修改用户权限！');location.href='../user/list.action';</script>");
		}
	}
		

}
