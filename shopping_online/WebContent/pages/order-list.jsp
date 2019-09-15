<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>用户管理 - 用户列表</title>
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/static/css/layout.css" rel="stylesheet">
  <style>
  	.fuzzyQuery{
  		display:block;
  		width:135px;
  		height:30px;
  	}
  	#fuzzyQInfo{
  	margin-bottom:-50px;
    text-align: right;
  	}
  </style>
  </head>
  
  <body>
    <!--==================================================加载库JQuery文件 -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <!-- 头部 -->
    <jsp:include page="header.jsp"/>
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
        <jsp:include page="navibar.jsp"/>
         </div>
        </div>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">订单列表</h1>
          <div class="row placeholders">
          <!-- 模糊搜索 -->
          <div>
       
          <div id="fuzzyQInfo">
      
          	<input id="fuzzyQInput" class="fuzzyQuery" type="text" name="userCode" placeholder="请输入订单号关键字"  value="${rderNum}">
          
           <select id="usertType"  style="width:150px;height:30px;font-size=24px;">
            	<option value="" ${orderss.orderState == null?'selected':'' } disabled selected hidden>订单状态</option>
            	<c:forEach items="${stapay.state}" var="state">
            	<c:if test="${state.orderState eq 0}">
            	   <option value="${state.orderState}" ${state.orderState eq orderss.orderState ?'selected':''}>待付款</option>
            	</c:if>
            	<c:if test="${state.orderState eq 1}">
            	   <option value="${state.orderState}" ${state.orderState eq orderss.orderState ?'selected':''}>已付款</option>
            	</c:if>
            	<c:if test="${state.orderState eq 2}">
            	   <option value="${state.orderState}" ${state.orderState eq orderss.orderState ?'selected':''}>已完成</option>
            	</c:if>
            	<c:if test="${state.orderState eq '-1'}">
            	   <option value="${state.orderState}" ${state.orderState eq orderss.orderState ?'selected':''}>已取消</option>
            	</c:if>
            	<c:if test="${state.orderState eq '-2'}">
            	   <option value="${state.orderState}" ${state.orderState eq orderss.orderState ?'selected':''}>已删除</option>
            	</c:if>
                </c:forEach>
                <option value="">全部</option>
            </select>
             <select id="userState" style="width:100px;height:30px;font-size=24px;">
            	<option value="" ${orderss.payWay == null?'selected':'' } disabled selected hidden>支付类型</option>
            	<c:forEach items="${stapay.payway}" var="payway">
            	<c:if test="${payway.payWay eq 1}">
            	   <option value="${payway.payWay}" ${payway.payWay eq orderss.payWay?'selected':''}>支付宝</option>
            	</c:if> 
            	<c:if test="${payway.payWay eq 2}">
            	   <option value="${payway.payWay}" ${payway.payWay eq orderss.payWay?'selected':''}>微信</option>
            	</c:if> 
            	<c:if test="${payway.payWay eq 3}">
            	   <option value="${payway.payWay}" ${payway.payWay eq orderss.payWay?'selected':''}>银联</option>
            	</c:if> 
            	</c:forEach>
            	<option value="">全部</option>
            	</select>
           
          	<button type="button" id="fuzzyQuery" class="btn btn-primary show-user-form">搜索</button>
          </div><br/>
          <script>
          //
          $(".fuzzyQuery").css("display","inline").css("color","green");
          $(".fuzzyQuery").click(function(){
        	//点击之后颜色发生该变
        	$(".fuzzyQuery").css("color","green");
          });
          //点击搜按钮
	       	$("#fuzzyQuery").click(function(){
	       		//点击之后颜色发生该变
	       		//alert("**点击搜按钮**")
	       		$(".fuzzyQuery").css("color","grey");
	       		//获取到文本框里的值
	       		var orderNum =($("#fuzzyQInput").val());
	       		//获取下列框中的值
	       		var orderState=$("#usertType option:selected").val(); 
	       		//获取下列框中的值
	       		var payWay=$("#userState option:selected").val(); 
	       		console.log(orderNum+"**"+orderState+"**"+payWay+"**");
	       		location.href="${pageContext.request.contextPath}/order/list.action?orderNum="+orderNum+"&orderState="+orderState+"&payWay="+payWay;
          	});
          
          </script>
          
         	<div>
                <button type="button" class="btn btn-warning export-date-userInfo" >导出数据</button>
                <!-- data-toggle="modal" data-target="#delete-confirm-dialog" -->
                <!--  删除所选对话框 -->
                <div class="modal fade " id="delete-confirm-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >警告</h4>
                      </div>
                      <div class="modal-body">
                        	确认删除所选用户吗
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary delete-selected-confirm">确认</button>
                      </div>
                    </div>
                  </div>
                </div>
<!--**********************添加新用户表单***********************-->
              
<!-- 用户列表数据展示区 -->
             <table class="table table-hover table-bordered role-list">
            	<tr>
            		<td>订单id</td>
                    <td>订单号</td>
                    <td>金额</td>
                    <td>支付方式</td>
                    <td>订单状态</td>
                    <td>创建时间</td>
                    <td>下单用户</td>
                    <td>操作</td>
                </tr>
                <!-- 遍历展示角色 -->
                <c:forEach items="${page.resultList}" var="order">
	                <tr>
	                 	<td class="orderId">${order.orderId }</td>
	                    <td class="orderNum">${order.orderNum }</td>
	                    <td class="totalMoney">${order.totalMoney }</td>
	                    <c:if test="${order.payWay eq 1}" > 
		                  <td class="payWay">支付宝</td>
	                    </c:if>
	                    <c:if test="${order.payWay eq 2}" > 
		                  <td class="payWay">微信</td>
	                    </c:if>
	                    <c:if test="${order.payWay eq 3}" > 
		                  <td class="payWay">银联</td>
	                    </c:if>
	                     
	                    <c:if test="${order.orderState eq 0}" > 
		                  <td class="orderState">待付款</td>
	                    </c:if>
	                     <c:if test="${order.orderState eq 1}" > 
		                  <td class="orderState">已付款</td>
	                    </c:if>
	                     <c:if test="${order.orderState eq 2}" > 
		                  <td class="orderState">已完成</td>
	                    </c:if>
	                     <c:if test="${order.orderState eq -1}" > 
		                  <td class="orderState">已取消</td>
	                    </c:if>
	                     <c:if test="${order.orderState eq -2}" > 
		                  <td class="orderState">已删除</td>
	                    </c:if> 
	                    
	                    <td class="createTime">${order.createTime }</td>
	                    <td class="userId">${(order.memberInfo).nickName}</td>
		               <td > 
		               	<button type="button" class="btn btn-primary findOrder">订单详情</button>
		              	<c:if test="${order.orderState eq 0}">
		              			<button type="button" disabled class="btn btn-primary deliver-list" data-toggle="modal" data-target="#deliver-userrole-dialog">发货信息</button>              	
		              	</c:if>
		              	<c:if test="${order.orderState ne 0}">
		              	<button type="button"  class="btn btn-primary deliver-list" data-toggle="modal" data-target="#deliver-userrole-dialog">发货信息</button>
		              	</c:if>
		              	<c:if test="${not empty order.invoice}">
		              			<button type="button"  class="btn btn-primary btn-invoice" data-toggle="modal" data-target="#update-userrole-dialog">开票信息</button>
		              	</c:if>
		             	<%-- <c:if test="${order.invoice == null">
		              			<button type="button" disabled class="btn btn-primary show-user-form" data-toggle="modal" data-target="#update-userrole-dialog">开票信息</button><br><br>
		              	</c:if> --%>
		               
		               </td>

                </c:forEach>
            </table>
<!-- 用户列表数据展示区结束 -->
              <jsp:include page="standard.jsp"/>
            <!--修改用户角色表单-->
            <div class="modal fade " id="update-userrole-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >开票信息</h4>
                      </div>
                      <div class="modal-body">
                      	<div class="modal-body">
                      	<!-- from表单修改 -->
                      	<form method="post" action="##">
                          <div class="form-group">
                            <label >订单号</label>
                            <input id="InceorderId" type="text" name="userCode" readonly class="form-control"  placeholder="用户名">
                          </div>
                          <div class="form-group">
                            <label >开票抬头</label>
                            <input id="title" type="text" name="nickName" readonly class="form-control"  placeholder="昵称">
                          </div>
                         <!--  -->
                         <div class="form-group">
                            <label >开票内容</label>
                            <input id="context" type="text" name="nickName" readonly  class="form-control" placeholder="昵称">
                          </div>
                           <div class="form-group">
                            <label >开票状态</label>
                            <input id="state" type="text" name="nickName" readonly class="form-control"   placeholder="昵称">
                          </div>
                           <div class="form-group">
                            <label >创建时间</label>
                            <input id="createTime" type="text" name="nickName" readonly class="form-control"  placeholder="昵称">
                          </div>
                           <div class="form-group">
                            <label >开票金额</label>
                            <input id="money" type="text" name="nickName" readonly class="form-control"   placeholder="昵称">
                          </div>
                           <div class="modal-footer">
	                       <input type="reset" value="取消" class="btn btn-default" data-dismiss="modal"/>
	                       <input type="submit" id="Insubmit" value="确定" class="btn btn-primary "/>
	                     </div>
                        </form>
                        <!-- from表单修改结束 -->
                      </div>
                    </div>
                  </div>
            </div>
          </div> 
          
          
          <div class="modal fade " id="deliver-userrole-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >发货单</h4>
                      </div>
                      <div class="modal-body">
                      	<div class="modal-body">
                      	<!-- from表单修改 -->
                      	<form method="post" action="##">
                          <div class="form-group">
                            <label >订单号</label>
                            <input id="DeorderId" type="text" name="DeorderId" readonly class="form-control"  placeholder="用户名">
                          </div>
                          <div class="form-group">
                            <label >发货单号</label>
                            <input id="deliverNum" type="text" name="deliverNum" class="form-control"  placeholder="昵称">
                          </div>
                         <!--  -->
                         <div class="form-group">
                            <label >skuid</label>
                            <input id="DeskuId" type="text" name="DeskuId" readonly  class="form-control" placeholder="昵称">
                          </div>
                           <div class="form-group">
                            <label >发货状态</label>
                            <input id="Destate" type="text" name="Destate" readonly class="form-control"   placeholder="昵称">
                          </div>
                           <div class="form-group">
                            <label >物流信息</label>
                            <input id="deliverInfo" type="text" name="deliverInfo" readonly class="form-control"  placeholder="昵称">
                          </div>
                           <div class="form-group">
                            <label >备注</label>
                            <input id="remark" type="text" name="nickName" readonly class="form-control"   placeholder="昵称">
                          </div>
                           <div class="modal-footer">
	                       <input type="reset" value="取消" class="btn btn-default" data-dismiss="modal"/>
	                       <button type="button" id="defaultsubmit" class="btn btn-primary" data-toggle="modal">发货</button>
	                     </div>
                        </form>
                        <!-- from表单修改结束 -->
                      </div>
                    </div>
                  </div>
            </div>
          </div>        
        </div>
    </div>
    </div>
    <!-- 提示框 -->
	<div class="modal fade" id="op-tips-dialog" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
      <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
        	<div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >提示信息</h4>
          </div>
          <div class="modal-body" id="op-tips-content">
          </div>
        </div>
      </div>
    </div>
  <!-- Bootstrap core JavaScript-->
   <!-- ================================================== -->
    <script>
//点击添加按钮时非空验证
	$(".btn-invoice").click(function(){
		var order=$(this).parents("tr");
		//获取id
		var orderId=order.find(".orderId").html();
			 $.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/order/invoice.action",
				dataType:"json",
				data:{
					orderId:orderId,
	            }, 
	            //请求成功
	            success:function(json){ 
	            	$("#InceorderId").val(json.Invoice.orderId);
	            	$("#title").val(json.Invoice.title);
	            	$("#context").val(json.Invoice.context);
	            	if(json.Invoice.state == 0){
	            		$("#state").val('未审核');
	            		$("#Insubmit").removeAttr("disabled");
	            	}else{
	            		$("#state").val('已审核');
	            		$("#Insubmit").attr("disabled", true);
	            	}
	            	$("#createTime").val(json.Invoice.createTime);
	            	$("#money").val(json.Invoice.money);
	            },
	            //请求失败了
	            error:function (){
	                alert("系统错误！");
	             } 
			});  
	});
 

/* 订单 */
	$(".deliver-list").click(function(){
		var order=$(this).parents("tr");
		//获取id
		var orderId=order.find(".orderId").html();
		console.log(orderId);
			 $.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/order/deliver.action",
				dataType:"json",
				data:{
					orderId:orderId,
	            }, 
	            //请求成功
	            success:function(json){ 
	            	if(json.deliver!=null){			
	            	$("#DeorderId").val(json.deliver.orderId);
			            	if(json.deliver.deliverNum!=null || json.deliver.deliverNum!=''){
			            	$("#deliverNum").val(json.deliver.deliverNum);
			            	}
			            	if(json.deliver.deliverNum==null || json.deliver.deliverNum==''){
			            	$("#deliverNum").val('');
			            	$("#deliverNum").removeAttr("readonly");
			            	}
			            	$("#DeskuId").val(json.deliver.skuId);
			            	if(json.deliver.state == 0){
			            		$("#Destate").val('未发货');
			            		$("#defaultsubmit").attr("disabled",false);
			            	} else{
			            		$("#Destate").val('已发货');
			            		$("#defaultsubmit").attr("disabled", true);
			            	}
			            	$("#deliverInfo").val(json.deliver.deliverInfo);
			            	$("#remark").val(json.deliver.remark);
			            	}else{
			            		$("#DeorderId").val('');
				            	$("#deliverNum").val('');
				            	$("#DeskuId").val('');
				            	$("#Destate").val('');
				            	$("#defaultsubmit").attr("disabled",false);
				            	$("#deliverInfo").val('');
				            	$("#remark").val('');
			            		}
	            },
	            //请求失败了
	            error:function (){
	                alert("系统错误！");
	             } 
			}); 
	});
 
 
 /* 修改发货单状态 */
 
 $("#defaultsubmit").click(function(){
		var val =$("#DeorderId").val();
		var deliverNum =$("#deliverNum").val();
		location.href="${pageContext.request.contextPath}/order/updeliver.action?deliverNum="+deliverNum+"&orderId="+val;
		  
	});
/* <!-- *************************开票点击事件********************************* --> */
	$("#Insubmit").click(function(){
		var val = $("#InceorderId").val();
		$.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/order/upvoice.action",
			data:{
				orderId:val,
            }, 
            //请求成功
            success:function(json){ 
            },
            //请求失败了
            error:function (){
                alert("系统错误！");
             } 
		}); 
	});


/* <!-- *****************导出数据点击事件*********************** -->  */	
	$(".export-date-userInfo").click(function(){
		//alert("导出数据");
		if(confirm('您确认要导出订单详情的数据吗？')){
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/order/exportUserInfo.action",
				dataType:"json",
				//请求成功
		        success:function(json){ 
		        	if(json.EXPORT_MSG==1){
		        	//alert("请求成功");
		        	location.href="${pageContext.request.contextPath}/pages/order-list-download.jsp";
		        	}else{
		        		alert("导出数据出现异常，请重新导出");
		        	}
		        },
				error:function (){
		           	alert("系统错误！");
		        }
			});
		} 
	});

    
    /* 跳转详情 */
   $(".findOrder").click(function(){
   	var cc=$(this).parents("tr");
   	var id = cc.find(".orderId").text();
	   console.log(id+"****************");
	   location.href="${pageContext.request.contextPath}/order/Itemlist.action?orderId="+id;
   });
    
    
    
    
    
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
    
    
    
    
    
    
    
		
    </script>
  </body>
</html>
