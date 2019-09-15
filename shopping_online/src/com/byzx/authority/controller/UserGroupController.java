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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.byzx.authority.service.UserGroupService;
import com.byzx.authority.service.UserInfoService;
import com.byzx.authority.vo.GroupRole;
import com.byzx.authority.vo.PageUtil;
import com.byzx.authority.vo.Role;
import com.byzx.authority.vo.UserGroup;
import com.byzx.authority.vo.UserInfo;
import com.byzx.authority.vo.UserRole;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/group")
public class UserGroupController {
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private UserGroupService userGroupService;
	
	//展示角色信息的后台
	@RequestMapping("/list.action")
	@ResponseBody					//jQuer中的Ajax注解	
	public void listUser(String groupName,String groupState,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("***已经进入用户组列表页面的后台***" );
		
		System.err.println("**已经用户组进入模糊搜索和列表展示fuzzyQuery后台***" );
		System.err.println("点击模糊搜索按钮后出传过来的roleName为："+groupName );
		System.err.println("点击模糊搜索按钮后出传过来的roleState为："+groupState );
		HttpSession session = request.getSession();
		//模糊查询回显，存的角色户名
		session.setAttribute("groupName", groupName);
		session.setAttribute("groupState", groupState);
		//采用动态sql查User_group表,页面展示的时候是全查了,参数是假的
		//模糊搜索的时候是有条件的查,参数是真的
		Map<String,Object> map = new HashMap<String,Object>();
		UserGroup userGroup = new UserGroup();
		userGroup.setGroupName(groupName);
		userGroup.setGroupState(groupState);
		map.put("userGroup", userGroup);
		map.put("page", null);
		//将传参数的userGroup对象给存起来
		session.setAttribute("USERGROUP_LIST", userGroup);
		//查询user_group表
		List<UserGroup> groups = userGroupService.findGroupFuzzy(map);
		//存共有多少条信息
		request.getSession().setAttribute("GLIST",groups.size());
		System.err.println("查出来的角色为"+groups);
		//遍历所有的用户组
		for(UserGroup group:groups) {
			System.err.println(group);
		}
		//跳转后台   后台.this.后台里面的方法名(参数,request, response)
		Integer pageNum = (Integer) session.getAttribute("GROUP_PAGE_NUM");
		UserGroupController.this.groupPage(pageNum,request, response);
	}
	//分页的后台
	@RequestMapping("groupPage.action")
	@ResponseBody
	public void groupPage(Integer pageNum, HttpServletRequest request, HttpServletResponse response) throws IOException{
		pageNum =pageNum==null?1:pageNum;
		HttpSession session = request.getSession();
		session.setAttribute("GROUP_PAGE_NUM", pageNum);
		//第一个参数为每页显示几条数据
		//第二个参数为当前为第几页
		PageUtil PageUtil = new PageUtil(5,pageNum);
		//取出上个后台里面的UserGroup对象
		UserGroup userGroup =(UserGroup) session.getAttribute("USERGROUP_LIST");
		//取出存的共几条数据
		Integer totalNum=(Integer) session.getAttribute("GLIST");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userGroup", userGroup);
		map.put("page", PageUtil);
		//全查角色表
		List<UserGroup> rlist = userGroupService.findGroupFuzzy(map);
		PageUtil pageUtil = new PageUtil(5,totalNum, pageNum,rlist,"group/groupPage.action",null);
		request.getSession().setAttribute("page",pageUtil);
		PrintWriter out = response.getWriter();
		out.print("<script>location.href='../pages/userGroup-list.jsp';</script>");	
	}
	//判断角色名称的唯一性roleNameIsExist.action
	@RequestMapping("/groupNameIsExist.action")
	@ResponseBody						
	public JSONObject groupNameIsExist(String groupName,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**判断用户组名称的唯一性的后台***" +groupName);
		Map<String,Object> map = new HashMap<String,Object>();
		UserGroup userGroup = new UserGroup();
		userGroup.setGroupName(groupName);
		map.put("userGroup", userGroup);
		String msg="";
		if(userGroupService.isExistGroupInfo(map)) {
			msg="1";
		}else {
			msg="2";
		}
		//new JSON 对象
		JSONObject data = new JSONObject();
		data.put("MSG",msg);
		return data;
	}
	//判断用户组Code的唯一性groupCodeIsExist.action
	@RequestMapping("/groupCodeIsExist.action")
	@ResponseBody						
	public JSONObject roleCodeIsExist(String groupCode,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**判断用户组Code的唯一性的后台***" +groupCode);
		Map<String,Object> map = new HashMap<String,Object>();
		UserGroup userGroup = new UserGroup();
		userGroup.setGroupCode(groupCode);
		map.put("userGroup", userGroup);
		String msg="";
		if(userGroupService.isExistGroupInfo(map)) {
			msg="1";
		}else {
			msg="2";
		}
		//new JSON 对象
		JSONObject data = new JSONObject();
		data.put("MSG",msg);
		return data;
	}
	//点击添加角色的按钮进入的后台
	@RequestMapping("/addGroupInfo.action")
	@ResponseBody						
	public void addGroupInfo(UserGroup userGroup,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**已经进入添加角色的后台***" +userGroup);
		System.err.println("**用户组名称**"+userGroup.getGroupName());
		System.err.println("**用户组描述**"+userGroup.getGroupDesc());
		System.err.println("**用户组代码**"+userGroup.getGroupCode());
		HttpSession session = request.getSession();
		UserInfo userInfo = (UserInfo)session.getAttribute("USER_INFO");
		System.err.println("**用户组创建人id**"+userInfo.getUserId());
		String createBy="";
		createBy = null!=userInfo?userInfo.getUserId().toString():"";
		userGroup.setCreateBy(createBy);
		PrintWriter out = response.getWriter();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userGroup", userGroup);
		if(userGroupService.insertOneGroup(map)) {
			out.print("<script>alert('用户组添加成功！');location.href='../group/list.action';</script>");	
		}
		out.print("<script>alert('用户组添加失败！');location.href='../group/list.action';</script>");	
	}
	//修改用户组进入的后台changeGroupInfo.action
	@RequestMapping("/changeGroupInfo.action")
	@ResponseBody						
	public void changeGroupInfo(UserGroup userGroup,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**已经进入修改角色的后台***" +userGroup);
		System.err.println("**角色名称**"+userGroup.getGroupName());
		System.err.println("**角色描述**"+userGroup.getGroupDesc());
		System.err.println("**角色roleid**"+userGroup.getGroupId());
		PrintWriter out = response.getWriter();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userGroup", userGroup);
		if(userGroupService.updateOneGroup(map)) {
			out.print("<script>alert('用户组修改成功！');location.href='../group/list.action';</script>");	
			}
		out.print("<script>alert('用户组修改失败！');location.href='../group/list.action';</script>");
	}
	//删除角色的后台
	@RequestMapping("/deleteOneUserGroup.action")
	@ResponseBody						
	public void deleteOneUserGroup(Integer groupId,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**已经进入删除用户组的后台***" +groupId);
		PrintWriter out = response.getWriter();
		UserGroup userGroup = new UserGroup();
		userGroup.setGroupId(groupId);
		userGroup.setIsDelete("1");
		if(userGroupService.deleteUserGroup(userGroup)) {
			out.print("<script>alert('用户组删除成功！');location.href='../group/list.action';</script>");	
			}
		out.print("<script>alert('用户组删除失败！');location.href='../group/list.action';</script>");
	}
	//启用/禁用用户组enabAndDisOneGroup.action
	@RequestMapping("/enabAndDisOneGroup.action")
	@ResponseBody						
	public void enabAndDisOneGroup(Integer groupId,String groupState,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**已经进入启用/禁用用户组的后台groupId***" +groupId);
		System.err.println("**已经进入启用/禁用用户组的后台grouopState***" +groupState+"***********");
		PrintWriter out = response.getWriter();
		UserGroup userGroup = new UserGroup();
		userGroup.setGroupId(groupId);
		userGroup.setGroupState(groupState);
		String groupState1=groupState.equals("0")?"禁用":"启用";
		if(userGroupService.enAndDisGroup(userGroup)) {
			out.print("<script>alert('用户组"+groupState1+"成功！');location.href='../group/list.action';</script>");	
			}
		out.print("<script>alert('用户组"+groupState1+"失败！');location.href='../group/list.action';</script>");
	}
	
	//给用户分配角色的后台
	@RequestMapping("/assignUserGroupRoles.action")
	@ResponseBody
	public JSONArray assignUserGroupRoles(Integer groupId,HttpServletRequest request, HttpServletResponse response) {
		System.err.println("给用户zu分配角色的后台assignUserGroupRoles.action"+"用户id"+groupId );
		HttpSession session = request.getSession();
		//将传过来的当前用户的id存入session
		session.setAttribute("CURR_GROUPID", groupId);
		//当前用户组角色的id字符串，
		String groupIdStr = userGroupService.findAllRoleIdString(groupId);
		System.err.println("长度"+groupIdStr.length()+"全查出来的结果为："+groupIdStr);
		//用,切割字符串变为字符串数组,用json返回到页面
		JSONArray jsonArray = new JSONArray();
		if(groupIdStr!=null) {
			String[] groupIdStringArray = groupIdStr.split(",");
			for(int i=0;i<groupIdStringArray.length;i++) {
				jsonArray.add(groupIdStringArray[i]);
			}
			//session.setAttribute("assignUserRoleId", rolesIdStringArray);
		}
		return jsonArray;
	}
	//点击了给用户组分配角色的按钮时进入的后台
	@RequestMapping("/comfirmAssRoleSubmit.action")
	@ResponseBody
	@Transactional			//用name值接收复选框传过来的value值 selectedAssignIds
	public void comfAssRoleSubmit(Integer[] groupRIds, HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("点击了给用户分配角色的按钮时进入的后台comfirmAssignSubmit.action"+"数组为id:"+groupRIds );
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		if(null!=groupRIds) {
			//从session中取出,传过来的当前用户的id存入
			Integer groupId = (Integer)session.getAttribute("CURR_GROUPID");
			System.err.println("取出来的用户组id为："+groupId);
			GroupRole groupRole = new GroupRole();
			//删除该用户组的所有角色
			userGroupService.deleteThisGroupRoles(groupId);
			//遍历给该用户添加角色
			for(Integer groupRId:groupRIds) {
				System.out.println("点击了给用户分配角色的按钮时分配的角色id为="+groupRId);
				groupRole.setGroupId(groupId);
				groupRole.setRoleId(groupRId);
				userGroupService.insertRolesForGroup(groupRole);
			}
			out.println("<script>alert('成功为该用户组发配了角色！');location.href='../group/list.action';</script>");
		}
		out.println("<script>alert('分配角色失败！');location.href='../group/list.action';</script>");
	}

	
	
	

}
