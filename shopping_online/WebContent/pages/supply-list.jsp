<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>店铺 信息</title>
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/static/css/layout.css" rel="stylesheet">
     <style type="text/css">
     	.red{color:red}
   </style>
  </head>
  <body>
    <!-- 头部 -->
    <jsp:include page="header.jsp"/>
    
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <jsp:include page="navibar.jsp"/>
         </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">供货商信息</h1>
          <div class="row placeholders">
          <div>
          <c:if test="${fn:indexOf(authCodes, ',select_userGroup,')!=-1}">
        <form action="${pageContext.request.contextPath}/Supply/findAllSupply.action" method="post">
          <input type="text" name="supplyName" id="supplyName" placeholder="供货商名称" value="${param.supplyName}">&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="submit" value="查询" class="btn btn-primary" >
          </form> 
          </c:if>
          </div><br/>
              
         	<div>
         	    
            
                <c:if test="${fn:indexOf(authCodes, ',add_userGroup,')!=-1}"> 
                 <button type="button" class="btn btn-primary show-user-form" data-toggle="modal" data-target="#add-user-form">添加供货商</button>
                </c:if> 
                <!--添加新用户组表单-->
                
                <div class="modal fade " id="add-user-form" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >添加供货商</h4>
                      </div>
                      <div class="modal-body">
                      	
                          <div class="form-group">
                            <label for="SupplyNameInput">供货商名称</label>
                            <input type="text" name="supplyName" class="form-control" id="SupplyNameInput" placeholder="供货商名称">
                             <label id="SupplyNameError"></label>
                          </div>
                          
                        
                            <div class="form-group">
                            <label for="supplyNumInput">供货商编号</label>
                            <input type="text" name="supplyNum" class="form-control" id="supplyNumInput" placeholder="供货商编号">
                             <label id="supplyNumError"></label>
                          </div>
                          
                           <div class="form-group">
                            <label for="supplyIntroduceInput">供货商介绍</label>
                            <input type="text" name="supplyIntroduce" class="form-control" id="supplyIntroduceInput" placeholder="供货商介绍">
                             <label id="supplyIntroduceError"></label>
                          </div>
                          
                            <div class="form-group">
                            <label for="concatInput">联系人</label>
                            <input type="text" name="concat" class="form-control" id="concatInput" placeholder="联系人">
                             <label id="concatError"></label>
                          </div>
                          
                           <div class="form-group">
                          <label for="phoneInput">联系电话</label>
                            <input type="text" name="phone" class="form-control" id="phoneInput" placeholder="联系电话">
                            <label id="phoneError"></label>
                          </div> 
                          
                        <div class="form-group">
                          <label for="addressInput">地址</label>
                            <input type="text" name="address" class="form-control" id="addressInput" placeholder="地址">
                            <label id="addressError"></label>
                          </div> 
                       
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default reset-userGroup-submit" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary add-userGroup-submit" onclick="return adduserGroup()">添加 </button>
                      </div>
                    </div>
                  </div>
                </div>
                
            </div>
            <div class="space-div"></div>
               <table class="table table-hover table-bordered user-list" style="text-align: center;">
            	<tr>
                    <td>ID</td>
                    <td>供货商编号</td>
                    <td>供货商名称</td>
                    <td>供货商介绍</td>
                    <td>联系人</td>
                    <td>联系电话</td>
                    <td>地址</td>
                    <td>操作</td>
                </tr>
        <c:forEach items="${page.resultList}" var="supply">
                	<tr>
                		<td class="supplyId">${supply.supplyId }</td>
                		<td class="supplyNum">${supply.supplyNum }</td>
                		<td class="supplyName">${supply.supplyName }</td>
                		<td class="supplyIntroduce">${supply.supplyIntroduce }</td>
                		<td class="concat">${supply.concat }</td>
                		<td class="phone">${supply.phone }</td>
	                    <td class="address">${supply.address}</td>
	                   <input type="hidden" value="${supply.supplyState}" class="groupStateInput"/>              		
	                    
                		 <td>
	                        <c:if test="${fn:indexOf(authCodes, ',update_user,')!=-1}">
	                    	   <a class="glyphicon glyphicon-wrench update-userGroup" aria-hidden="true" title="修供应商信息" href="" data-toggle="modal" data-target="#update-userinfo"></a>
	                    	</c:if>
	                    	<c:if test="${fn:indexOf(authCodes, ',delete_user,')!=-1}">
	                    	   <a class="glyphicon glyphicon-remove delete-this-user" aria-hidden="true" title="删除供应商信息" href="javascript:void(0);"></a>
	                    	</c:if>
	                    	</td>
                	</tr>
               </c:forEach>   
            </table>
              <jsp:include page="standard.jsp"/>
            <!--修改用户组信息-->
            <div class="modal fade " id="update-userinfo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
                  <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" >修改供货商信息</h4>
                      </div>
                      <div class="modal-body">
                      	
                          <input name="supplyId" type="hidden" id="groupId-userGroup" />
                          
                         <div class="user-div">
                            <label for="supplyNameInput">供货商名称<span style="color:red">(不可修改)</span></label>
                            <input type="text" name="supplyName" class="form-control" id="groupCode-userGroup" placeholder="供应商名称" readonly="readonly">
                            <label id="groupCodeError-userGroup"></label>
                          </div> 
                                                    
                          <div class="user-div">
                            <label for="supplyNumInput">供货商编号</label>
                            <input type="text" name="supplyNum" class="form-control" id="groupDesc-userGroup" placeholder="供货商编号">
                            <label id="groupDescError-userGroup"></label>
                          </div>
                          
                         <div class="user-div">
                            <label for="supplyIntroduceInput">供货商介绍</label>
                            <input type="text" name="supplyIntroduce" class="form-control" id="storePhone-userGroup" placeholder="供货商介绍">
                            <label id="storePhoneError-userGroup"></label>
                          </div>
                          
                          <div class="user-div">
                            <label for="concatInput">联系人</label>
                            <input type="text" name="concat" class="form-control" id="storeIntro-userGroup" placeholder="联系人">
                            <label id="storeIntroError-userGroup"></label>
                          </div>
                          
                           <div class="user-div">
                            <label for="phoneInput">联系电话</label>
                            <input type="text" name="phone" class="form-control" id="storeAgree-userGroup" placeholder="联系电话">
                            <label id="storeAgreeError-userGroup"></label>
                          </div>
                          
                           <div class="user-div">
                            <label for="addressInput">地址</label>
                            <input type="text" name="address" class="form-control" id="address-userGroup" placeholder="地址">
                            <label id="addressError-userGroup"></label>
                          </div>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default update-userGroup-reset" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary update-userGroup-submit" >提交 </button>
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
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script>
 
         //根据光标失去焦点用ajax请求判断编号是否存在
             var flag=true;
                 $(function(){
                   $("#placeNumInput").blur(function(){
                    var supplyNum=$("#supplyNumInput").val();//获取用户名
                    //alert("tang");
                     if(!!supplyNum){
                        if(!/^\w{3,16}$/.test(supplyNum)){
                          flag=false;
                         $("#supplyNumError").addClass("red").html("用户名不合法！必须4-16位、数字或字母、下划线");
                        }else{
                       $.ajax({
                        type:"post",
                        dataType:"json",
                        data:{
                          supplyNum:supplyNum
                        },
                        url:"${pageContext.request.contextPath}/Supply/findAllSupplyBysupplyNum.action",
                        success:function(data){
                          if(data.ree=='1'){
                            flag=true;
                            $("#supplyNumError").removeClass("red").html("");
                          }else{
                            flag=false;
                            $("#supplyNumError").addClass("red").html("编号已存在");
                          }
                        },
                         error:function(){
                          alert("系统错误！");
                       }
                       });
                       }
                     }else{
                       flag=false;
                       $("#supplyNumError").addClass("red").html("编号不能为空！");
                     }
                   });
                 });
          //用户组添加，并非空校验------ start-------------
          function adduserGroup(){
	           var groupName=$("#SupplyNameInput").val();//获取用户组名
	           var groupDesc=$("#supplyNumInput").val();//获取
	           var supplyIntroduce=$("#supplyIntroduceInput").val();
	           var concat=$("#concatInput").val();
	           var phone=$("#phoneInput").val();
	           var address=$("#addressInput").val();
	           
	           if(!/^\S{3,16}$/.test(groupName)){ //正则表达式校验
	             $("#SupplyNameError").addClass("red").html("店铺名称名不合法！必须3-16位、中文、数字或字母、下划线");
	               return false;
	           }/* else if(!/^\w{5,30}$/.test(groupCode)){
	             $("#groupNameError").removeClass("red").html("");
	             $("#groupCodeError").addClass("red").html("code不合法！必须5-30位、数字或字母、下划线");
	               return false;
	           } */else if(!/^\S{0,30}$/.test(supplyIntroduce)){
	             $("#SupplyNameError").removeClass("red").html("");
	             $("#supplyIntroduceError").addClass("red").html("描述不合法！必须0-30位、中文、数字或字母、下划线");
	               return false;
	           }else if(!flag){
	           alert("编号已存在");
	           }else{
	             $("#SupplyNameError").removeClass("red").html("");
	          //   $("#groupCodeError").removeClass("red").html("");//赋空
	             $("#supplyIntroduceError").removeClass("red").html("");
	            $.ajax({
	                type:"post",//隐藏请求传参
	                dataType:"json",//返回json对象
	                data:{
	                supplyName:groupName,//键值对
	                supplyNum :groupDesc,
	                supplyIntroduce:supplyIntroduce,
	                concat:concat,
	                phone:phone,
	                address:address
	                },
	                url:"${pageContext.request.contextPath}/Supply/addSupply.action",//跳转控制层
	                success:function(data){
	                   if(data.re=='-1'){
	                     //alert("code已存在！");
	                     $("#SupplyNameError").addClass("red").html("供货商名称已存在！");
	                   }else if(data.re=='1'){
	                     alert("添加成功！");
	                     location.reload();//刷新当前页面
	                   }else if(data.re=='0'){
	                     alert("添加失败！");
	                   }
	                },
	                error:function(){
	                 alert("系统错误！");
	                }
	            });
              }
            }    
         //用户组添加，并非空校验----------end-------------
            
                
        //添加时点取消按钮刷新当前页面-------start----------
        $(function(){
           $(".reset-userGroup-submit").click(function(){
                 location.reload();
           });
        });
        //添加时点取消按钮刷新当前页面-------end----------
     
                


       //修改用户组前用信息回显----------start-----------
       $(function(){
	        $(".update-userGroup").click(function(){
	         var supplyId=$(this).parents("tr").find(".supplyId").text();//获取当前对象用户组id
	         var supplyNum=$(this).parents("tr").find(".supplyNum").text();//获取当前对象用户组名
	         var supplyName=$(this).parents("tr").find(".supplyName").text();//获取当前
	         var supplyIntroduce=$(this).parents("tr").find(".supplyIntroduce").text();//获取当前
	         var concat=$(this).parents("tr").find(".concat").text();//获取当前介绍
	         var phone=$(this).parents("tr").find(".phone").text();//获取
	         var address=$(this).parents("tr").find(".address").text();//获取
	         
	         $("#groupId-userGroup").val(supplyId);//赋值后回显
	         $("#groupCode-userGroup").val(supplyName);//赋值后回显
	         $("#groupDesc-userGroup").val(supplyNum);//赋值后回显
	         $("#storePhone-userGroup").val(supplyIntroduce);//赋值后回显
	         $("#storeIntro-userGroup").val(concat);//赋值后回显
	         $("#storeAgree-userGroup").val(phone);//赋值后回显
	    	 $("#address-userGroup").val(address);//赋值后回显
	         
	        });
       });
       //修改用户组前用信息回显----------end-----------       
              
       //修改用户组信息-------------start--------------
      $(function(){
          $(".update-userGroup-submit").click(function(){
             var supplyId=$("#groupId-userGroup").val();//赋值后回显
	         var supplyNum=$("#groupDesc-userGroup").val();//赋值后回显
	         var supplyName=$("#groupCode-userGroup").val();//赋值后回显
	         var supplyIntroduce=$("#storePhone-userGroup").val();//赋值后回显	         
	         var concat=$("#storeIntro-userGroup").val();//赋值后回显
	         var phone=$("#storeAgree-userGroup").val();//赋值后回显
	         var address=$("#address-userGroup").val();//赋值后回显	         
            if(!/^\S{3,16}$/.test(supplyName)){ //正则表达式校验
	           $("#groupCodeError-userGroup").addClass("red").html("用户组名不合法！必须3-16位、中文、数字或字母、下划线");
	           return;
            }else if(!/^\S{0,30}$/.test(supplyIntroduce)){
               $("#groupCodeError-userGroup").removeClass("red").html("");
               $("#storePhone-userGroup").addClass("red").html("描述不合法！必须0-30位、中文、数字或字母、下划线");
               return;
            }else{
               $("#groupCodeError-userGroup").removeClass("red").html("");
               $("#storePhone-userGroup").removeClass("red").html("");
               //alert("name:"+groupName+",code:"+groupDesc+",用户组id:"+groupId);
               $.ajax({
                 type:"post",
                 dataType:"json",
                 data:{
                   supplyId:supplyId,
                   supplyNum:supplyNum,
                   supplyName:supplyName,
                   supplyIntroduce:supplyIntroduce,
                   concat:concat,
                   phone:phone,
                   address:address
                },
                  url:"${pageContext.request.contextPath}/Supply/updataAllSupply.action",
                  success:function(data){
                     if(data.re=='1'){
                       alert("修改成功！");
                       location.reload();//刷新当前页面
                     }else{
                       alert("修改失败！");
                     }
                 },
                  error:function(){
                    alert("系统错误！");
                  }
              }); 
            }
          });
       });  
       //修改用户组信息-------------end--------------
       
       //修改时点取消按钮刷新当前页面-------start----------
        $(function(){
           $(".update-userGroup-reset").click(function(){
                 location.reload();
           });
        });
       //添加时点取消按钮刷新当前页面-------end----------
  
  
              
       //逻辑删除用户ajax请求
              $(function(){
                $(".delete-this-user").click(function(){
                var supplyId=$(this).parents("tr").find(".supplyId").text();//获取当前对象用户id
                  $.ajax({
                     type:"post",
                     dataType:"json",
                     data:{
                     supplyId:supplyId
                     },
                     url:"${pageContext.request.contextPath}/Supply/deleteSupply.action",
                     success:function(data){
                       if(data.re=='1'){
                          alert("删除成功！");
                         location.reload();
                       }else{
                         alert("删除失败！");
                       }
                     },
                     error:function(){
                       alert("系统错误！");
                     }
                  });
                });
              });



    </script>
  </body>
</html>
