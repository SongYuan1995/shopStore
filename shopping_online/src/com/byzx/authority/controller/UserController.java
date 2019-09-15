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

import com.byzx.authority.service.UserService;
import com.byzx.authority.vo.MemberInfo;
import com.byzx.authority.vo.PageUtil;



@Controller
public class UserController {
	@Autowired
	private UserService userService;
	
	@RequestMapping("/user/listquanxian.action")	
	@ResponseBody
	public void isAxcvcvb(String groupName,String groupState,HttpServletRequest request, HttpServletResponse response) throws IOException {	
		HttpSession session = request.getSession();		
		System.out.println(groupName+"35555555");
		System.out.println(groupState+"33333");
		
		String groupName1="";		
		String groupState1=null;

		if(groupState!=null && groupState!=""){			
				groupState1=groupState;			
		
		}if(groupName!="" && groupName!=null ) {
			groupName1=groupName;
		}
		MemberInfo memberInfo=new MemberInfo();
		memberInfo.setNickName(groupName1);
		memberInfo.setUserState(groupState1);
		
		
		request.getSession().setAttribute("USERS", memberInfo);
		
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("user", memberInfo);
		map.put("page", null);
		List<MemberInfo> uist = userService.findUserInfoU(map);
		request.getSession().setAttribute("USERST",uist.size());
		UserController.this.isAsdfga2(1, request, response);
	
	
	}


	@RequestMapping("/user/al.action")	
	@ResponseBody
	public void isAsdfga2(Integer pageNum,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println(3333333);
		HttpSession session = request.getSession();
		pageNum=pageNum==null?1:pageNum;
		PageUtil pageUtil = new PageUtil(4,pageNum);
		MemberInfo usee=(MemberInfo)session.getAttribute("USERS");
		Integer inger=(Integer)session.getAttribute("USERST");
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("user", usee);
		map.put("page", pageUtil);		
		List<MemberInfo> ulist=userService.findUserInfoU(map);
	
		
		PageUtil pageUti2 = new PageUtil(4,inger,pageNum,ulist,"/user/al.action",null);
		request.getSession().setAttribute("page", pageUti2);
		PrintWriter out = response.getWriter();	
		out.println("<script>location='../pages/user-listquanxian.jsp';</script>");
}
	
	@RequestMapping("/user/alsss1.action")	
	@ResponseBody
	public void userState(Integer userId,String userState,HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();					
		HttpSession session = request.getSession();
		System.out.println(userId+"222222");
		System.out.println("000006666"+userState);
		Integer userState1=userState.equals("启用")?0:1;
		System.out.println(userState1+"888888");
		MemberInfo memberInfo = new MemberInfo();
		memberInfo.setUserId(userId);
		memberInfo.setUserState(userState1+"");
		userService.updateUserState1(memberInfo);
		
		UserController.this.isAsdfga2(1, request, response);
	
	}
	
	@RequestMapping("/user/xiu1.action")	
	public String userStates2(Integer userId,HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		System.out.println(userId+"222222555");
		userService.updateUserPwds(userId);
		return "user-listquanxian";
	
	}
	
	
	
}
	
	
	
	
	
	
	
	
