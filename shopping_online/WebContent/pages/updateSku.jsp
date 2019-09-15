<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css"	rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/static/css/layout.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="${pageContext.request.contextPath}/static/css/layout.css"
	rel="stylesheet">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
</head>
<style>
	body{
		 padding-top: 40px;
		  padding-bottom: 40px;
		  background-color: #eee;
	}
	

</style>
<body>
	<script
		src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
	<jsp:include page="header.jsp" />
			<!-- 显示该商品所有spc和dic -->
		
	<div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <jsp:include page="navibar.jsp"/>
         </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <div class="row placeholders" id="box">
		         	
         	<h1>商品SKU修改</h1>
         	<h3>规格概览</h3>
         	<c:forEach items="${SPEC}" var="spe">
			
				${spe.specCode}：${spe.specCode}
				<c:forEach items="${spe.dictionary}" var="dic">
					${dic.dicId}:${dic.dicName}:
				</c:forEach>
			</c:forEach>
         	<br/>
         	<br/>
         	<br/>
         	<%-- <c:forEach items="${SPEC}" var="spec"> --%>
         	
            <div class="space-div"></div>
            
               <form  enctype="multipart/form-data" class="user-form"	method="post"
                	action="${pageContext.request.contextPath}/productList/confirmUpdateSku.action" >
              
              <!-- 已经添加的sku -->
                <table class="table table-hover table-bordered ">
            	<tr>
                	<td><input type="checkbox" class="select-all-btn" /></td>
                    <td>商品Id</td>
                    <td>skuId</td>
                    <td>进价</td>
                    <td>售价</td>
                    <td>商品库存</td>
                    <td>图片</td>
                    <td>状态</td>
                    <td>规格字典</td>
                    <td>操作</td> 
                </tr>
                 <c:forEach items="${UPDATESKU}" var="sku"> 
                	
                	<tr class="oneSku" >
                		<td><input type="checkbox" name="userIds" value="" class="check"/></td>
                		<td >${sku.proId }<input class="proId" type="text" name="proId" value="${sku.proId }" style="display:none"/></td>
                		<td>${sku.skuId }<input class="skuId" type="text" name="skuIds" value="${sku.skuId }" style="display:none"/></td>
                		<td class=""><input style="width:75px" type="number" step="0.1" value="${sku.inPrice }"  class="inPrice" name="inPrices"/></td>
                		<td class=""><input style="width:75px" type="number" step="0.1" value="${sku.sellPrice }" class="sellPrice" name="sellPrices"/></td>
                		<td class=""><input style="width:75px" type="number" value="${sku.inventory }"  class="inventory" name="inventorys"/></td>
                		<td class=""><input style="width:75px" type="file" style="width:75px" name="files"/></td>
                		<td class="">
                			<select name="states">
                				<option value="1" ${sku.state eq '1'?'checked':'' }>启用</option>
                				<option value="0" ${sku.state eq '0'?'checked':'' }>禁用</option>
                			</select>
           					<input type="text" name="dicIds" value='${sku.dicids }' style="display:none"/>
            			</td>
                		 <td class="dicIds"><input type="text" name="dicIds" value='${sku.dicids}' readonly/></td>
                		 
	                     <td>
	                   		<button type="button" class="btn btn-primary deleteSku">删除sku</button> 
	                    </td> 
                	</tr>
               	 
                </c:forEach> 
            </table> 
				<input type="submit" class="btn btn-warning delete-query updateProUpDown addSku"  value="确认修改" />
               </form>
         
    
            
          </div>          
        </div>
    </div>
		
	
	
	
	
	
	
	<script type="text/javascript">
		var proId = "${param.proId }";
		/*  var update = "${UPDATESKU}";
		if (update=="") {
			//如果没有sku，则隐藏table
			$(".updateClass").css("display","none");
		}  */
		
		 function check(){
			
			/* var inPrice = $(this).parents(".oneSku").find(".inPrice").val();
			var sellPrice = $(this).parents(".oneSku").find(".sellPrice").val();
			var inventory = $(this).parents(".oneSku").find(".inventory").val();
			var dicIds ="{"+ $(this).parents(".oneSku").find(".dicIds").html()+"}";
			var state =$(this).parents(".oneSku").find("input[type=radio][name=state]:checked").val();
			 */
			
			return true;
					
		}; 
	
	
	
		$(function(){
			
			$(".deleteSku").click(function(){
				var tr = $(this).parents("tr");
				var skuId =  $(this).parents("tr").find(".skuId").val();
				var proId = $(this).parents("tr").find(".proId").val();
				console.log(skuId);
				location.href="${pageContext.request.contextPath}/productList/deleteSku.action?skuId="+skuId+"&proId="+proId;
			});
			
			
			
			
				
			
			
			
			
			
			
			
			
			
		});
	
	
		//获取特性和特性值集合
		
		//var 
		/* ${obj}.each(function(index,e){
			obj[0]
		
			console.log(obj);
		
		});*/
		 
			
		
		
		
		/* function newArray(array){
			var len = array.length
			
				var arr1 = array[0];
				var len1 = array[0].length;
				var arr2 = array[1];
				var len2 = array[1].length;
				var newLen = len1*len2;
				var index = 0;
				var temp = new Array(newLen);
				for (var i = 0; i <len1; i++) {
					for (var j = 0; j < len2; i++) {
						temp[index] = arr1[i] + "," +arr2[j];
						index ++;
					}
				}
				return temp;
		} */
	
	
	
	
	
	
	
	
	
	
	
	
	</script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/jquery.cookie.js"></script>
</body>
</html>