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
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.byzx.authority.service.RoleService;
import com.byzx.authority.service.UserInfoService;
import com.byzx.authority.vo.AuthInfo;
import com.byzx.authority.vo.PageUtil;
import com.byzx.authority.vo.Role;
import com.byzx.authority.vo.RoleAuth;
import com.byzx.authority.vo.UserAuth;
import com.byzx.authority.vo.UserGroup;
import com.byzx.authority.vo.UserInfo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/role")
public class RoleController {
	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private RoleService roleService;
	
	//展示角色信息的后台
	@RequestMapping("/list.action")
	@ResponseBody					//jQuer中的Ajax注解	
	public void listUser(String roleName,String roleState,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("***已经进入角色列表页面的后台***" );
		
		System.err.println("**已经进入模糊搜索fuzzyQuery后台***" );
		System.err.println("点击模糊搜索按钮后出传过来的roleName为："+roleName );
		System.err.println("点击模糊搜索按钮后出传过来的roleState为："+roleState );
		HttpSession session = request.getSession();
		//模糊查询回显，存的角色户名
		session.setAttribute("roleName", roleName);
		session.setAttribute("roleState", roleState);
		//采用动态sql联查User_info表和role,这里全查了,参数是假的
		Map<String,Object> map = new HashMap<String,Object>();
		Role role1 = new Role();
		role1.setRoleName(roleName);
		role1.setRoleState(roleState);
		map.put("role", role1);
		map.put("page", null);
		session.setAttribute("ROLE_LIST", role1);
		List<Role> roles = roleService.findRoles(map);//存共有多少条信息
		request.getSession().setAttribute("ULIST",roles.size());
		System.err.println("查出来的角色为"+roles);
		for(Role role:roles) {
			System.err.println(role);
		}
		//跳转后台   后台.this.后台里面的方法名(参数,request, response)
		Integer pageNum = (Integer) session.getAttribute("ROLE_PAGE_NUM");
		RoleController.this.rolePage(pageNum,request, response);
	}
	@RequestMapping("rolePage.action")
	@ResponseBody
	public void rolePage(Integer pageNum, HttpServletRequest request, HttpServletResponse response) throws IOException{
		pageNum =pageNum==null?1:pageNum;
		//第一个参数为每页显示几条数据
		//第二个参数为当前为第几页
		HttpSession session = request.getSession();
		session.setAttribute("ROLE_PAGE_NUM", pageNum);
		PageUtil PageUtil = new PageUtil(5,pageNum);
		//取出上个后台里面的role
		Role role =(Role) session.getAttribute("ROLE_LIST");
		//取出存的共几条数据
		Integer totalNum=(Integer) session.getAttribute("ULIST");
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("role", role);
		map.put("page", PageUtil);
		List<Role> rlist = roleService.findRoles(map);//全查角色表
		PageUtil pageUtil = new PageUtil(5,totalNum, pageNum,rlist,"role/rolePage.action",null);
		request.getSession().setAttribute("page",pageUtil);
		PrintWriter out = response.getWriter();
		out.print("<script>location.href='../pages/role-list.jsp';</script>");	
	}
	//判断角色名称的唯一性roleNameIsExist.action
	@RequestMapping("/roleNameIsExist.action")
	@ResponseBody						
	public JSONObject roleNameIsExist(String roleName,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**判断角色名称的唯一性的后台***" +roleName);
		Map<String,Object> map = new HashMap<String,Object>();
		Role role = new Role();
		role.setRoleName(roleName);
		map.put("role", role);
		String msg="";
		if(roleService.hasRoleInfo(map)) {
			msg="1";
		}else {
			msg="2";
		}
		//new JSON 对象
		JSONObject data = new JSONObject();
		data.put("MSG",msg);
		return data;
	}
	//判断角色Code的唯一性roleCodeIsExist.action
	@RequestMapping("/roleCodeIsExist.action")
	@ResponseBody						
	public JSONObject roleCodeIsExist(String roleCode,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**判断角色Code的唯一性的后台***" +roleCode);
		HttpSession session = request.getSession();
		Map<String,Object> map = new HashMap<String,Object>();
		Role role = new Role();
		role.setRoleCode(roleCode);
		map.put("role", role);
		String msg="";
		if(roleService.hasRoleInfo(map)) {
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
	@RequestMapping("/addRoleInfo.action")
	@ResponseBody						
	public void addRoleInfo(Role role,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**已经进入添加角色的后台***" +role);
		System.err.println("**角色名称**"+role.getRoleName() );
		System.err.println("**角色描述**"+role.getRoleDesc() );
		System.err.println("**角色代码**"+role.getRoleCode() );
		System.err.println("**角色创建人id**"+role.getCreateBy() );
		PrintWriter out = response.getWriter();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("role", role);
		if(roleService.insertOneRole(map)) {
			out.print("<script>alert('角色添加成功！');location.href='../role/list.action';</script>");	
		}
		out.print("<script>alert('角色添加失败！');location.href='../role/list.action';</script>");	
	}
	//判断角色名称的唯一性roleNameIsExist.action
	@RequestMapping("/changeNameIsExist.action")
	@ResponseBody						
	public JSONObject changeNameIsExist(String roleName,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**判断角色名称的唯一性的后台***" +roleName);
		Map<String,Object> map = new HashMap<String,Object>();
		Role role = new Role();
		role.setRoleName(roleName);
		map.put("role", role);
		String msg="";
		if(roleService.hasRoleInfo(map)) {
			msg="1";
		}else {
			msg="2";
		}
		//new JSON 对象
		JSONObject data = new JSONObject();
		data.put("MSG",msg);
		return data;
	}
	//点击修改角色的按钮进入的后台
	@RequestMapping("/changeRoleInfo.action")
	@ResponseBody						
	public void changeRoleInfo(Role role,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**已经进入修改角色的后台***" +role);
		System.err.println("**角色名称**"+role.getRoleName() );
		System.err.println("**角色描述**"+role.getRoleDesc() );
		System.err.println("**角色roleid**"+role.getRoleId());
		PrintWriter out = response.getWriter();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("role", role);
		if(roleService.updateOneRole(map)) {
			out.print("<script>alert('角色修改成功！');location.href='../role/list.action';</script>");	
			}
		out.print("<script>alert('角色修改失败！');location.href='../role/list.action';</script>");
	}
	//删除角色的后台
	@RequestMapping("/delectRoleInfo.action")
	@ResponseBody						
	public void deleteRoleInfo(Integer roleId,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**已经进入删除角色的后台***" +roleId);
		PrintWriter out = response.getWriter();
		if(roleService.deleteOneRole(roleId)) {
			out.print("<script>alert('角色删除成功！');location.href='../role/list.action';</script>");	
			}
		out.print("<script>alert('角色删除失败！');location.href='../role/list.action';</script>");
	}
	//启用/禁用
	@RequestMapping("/enableAndDisableRole.action	")
	@ResponseBody						
	public JSONObject enableAndDisableRole(Integer roleId,String roleState,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("**启用/禁用的后台roleId=***" +roleId);
		System.err.println("**启用/禁用的后台roleState=" +roleState);
		Role role = new Role();
		role.setRoleId(roleId);
		role.setRoleState(roleState);
		String msg="";
		if(roleService.enableAndDisable(role)) {
			msg="1";
		}else {
			msg="2";
		}
		//new JSON 对象
		JSONObject data = new JSONObject();
		data.put("MSG",msg);
		return data;
	}
	//修改权限
	
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
	@RequestMapping("/roleListChangeAuthority.action")
	@ResponseBody						
	public void userListChangeAuthority(Integer roleId,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("已经进入修改role权限时的后台**传过来的roleId="+roleId);
		HttpSession session = request.getSession();
		//将传过来的当前用户的id存入session
		session.setAttribute("CURR_ROLEID", roleId);
		//全查auth_info表
		List<AuthInfo> authInfos = userInfoService.findAllAuthInfo();
		//根据角色的的id查询该角色所有的权限id，一级，二级，三级权限
		List<RoleAuth> roleAuths = roleService.findAllAuthbyURoleId(roleId);
		//遍历List<RoleAuth>获取当前用户的List<RoleAuth>权限的id，将id放在数组中
		List<Integer> roleAuthIds = new ArrayList<Integer>();
		for(RoleAuth roleAuth:roleAuths) {
			roleAuthIds.add(roleAuth.getAuthId());
			System.err.println("角色的权限id为："+roleAuth.getAuthId());
		}
		System.err.println("角色的权限id个数"+roleAuths.size());
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
			if(roleAuthIds.contains(authInfo.getAuthId())) {
				jsonObject.put("checked", true);
			}else {
				jsonObject.put("checked", false);
			}
			System.err.println("当前权限"+authInfo);
			jsonArray.add(jsonObject);
		}
		request.getSession().setAttribute("roleJsonArray", jsonArray);
		PrintWriter out = response.getWriter();
		out.println("<script>location.href='../pages/roleListChangeAuthTree.jsp';</script>");
	}
	//角色页面点击确认修改权限的时候进入的后台comfirmChangeRoleAuth.action
	@RequestMapping("/comfirmChangeRoleAuth.action")
	@ResponseBody
	@Transactional	
	public void comfirmChangeRoleAuth(String thisroleAuthIdsStr,HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.err.println("已经进入修改权限时点击了确认修改权限时**传过来的权限id的字符串为="+thisroleAuthIdsStr);
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		Map<String,Object> map = new HashMap<String,Object>();
		//获取当前角色的id
		Integer roleId = (Integer)session.getAttribute("CURR_ROLEID");
		Integer i=0;
		if(""!=thisroleAuthIdsStr) {
			//删除user_auth表里的id为userId的所有auth_id
			roleService.delCurrRoleAuthIds(roleId);
			//拆分传过来的字符串
			String[] strArrAuthIds = thisroleAuthIdsStr.split(",");
			System.out.println("ids的字符数组为"+strArrAuthIds);
			for(String authId:strArrAuthIds ) {
				map.put("roleId", roleId);
				map.put("authId", authId);
				i = roleService.insertCurrRoleAuthId(map);
				i++;
			}
		}
		if(i==0) {
			out.println("<script>alert('权限修改失败！')location.href='${pageContext.request.contextPath}/role/roleListChangeAuthority.action?roleId="+roleId+"';</script>");
		}else if(i>0) {
			out.println("<script>alert('成功修改角色权限！');location.href='../role/list.action';</script>");
		}
	}
	
	
	
		
		
		
		
			
		/*//展示用户信息的后台
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
			AuthInfoController.this.lists(1,request, response);
		}
		
			
			
		@RequestMapping("sts.action")
		@ResponseBody
		public void lists(Integer pageNum, HttpServletRequest request, HttpServletResponse response) throws IOException{
			pageNum =pageNum==null?1:pageNum;
			//第一个参数为每页显示几条数据
			//第二个参数为当前为第几页
			PageUtil PageUtil = new PageUtil(5,pageNum);
			HttpSession session = request.getSession();
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
			out.print("<script>location.href='../pages/user-list.jsp';</script>");*/	
		
	
	
	
	
	
	
	
	
	
	
	
	
}
