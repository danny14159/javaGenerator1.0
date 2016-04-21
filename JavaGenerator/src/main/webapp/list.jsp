<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>列表页面</title>
</head>
<body>
<form class="form-inline">
<button type="submit" class="btn btn-default">查找</button>
</form><table class="table table-striped">
<tr>
	<th><input type="checkbox" onchange="toggleSelectAll(this,$('[name=selectRow]'));"/></th>
	<th>资产</th>
	<th>name</th>
	<th>model_no</th>
	<th>buying_price</th>
	<th>curr_state</th>
	<th>user</th>
	<th>store_location</th>
	<th>category_id</th>
	<th>responsive_people</th>
	<th>other_info</th>
	<th>using_expire</th>
	<th>department_id</th>
</tr>
	<c:forEach items="${pager.list }" var="i">
<tr>
<td><input type="checkbox" checked="checked" name="selectRow"/></td>
	<td><c:out value="${i.id}"></c:out></td>
	<td><c:out value="${i.name}"></c:out></td>
	<td><c:out value="${i.model_no}"></c:out></td>
	<td><c:out value="${i.buying_price}"></c:out></td>
	<td><c:out value="${i.curr_state}"></c:out></td>
	<td><c:out value="${i.user}"></c:out></td>
	<td><c:out value="${i.store_location}"></c:out></td>
	<td><c:out value="${i.category_id}"></c:out></td>
	<td><c:out value="${i.responsive_people}"></c:out></td>
	<td><c:out value="${i.other_info}"></c:out></td>
	<td><fmt:formatDate value="${i.using_expire}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	<td><c:out value="${i.department_id}"></c:out></td>
</tr>
</c:forEach>
</table>
<div id="pager"></div>
<script type="text/javascript" src="/static/js/jquery.min.js"></script>
<script type="text/javascript" src="/static/laypage/laypage.js"></script>
<script type="text/javascript">
$(function(){
	laypage({
	    cont: "pager",
	    pages: "${pager.pageCount}", 
	    curr: "${pager.pageNumber}", 
	    jump: function(e, first){ 
	        if(!first){ 
	            location.href = "?ps=${pager.pageSize}$pn="+e.curr;
	        }
	    }
	});
})
function toggleSelectAll(self,$sel){
	if(self.checked)
		$sel.each(function(){
			if(!this.checked) $(this).click();
		});
	else{
		$sel.each(function(){
			if(this.checked) $(this).click();
		});
	}
}
</script>
</body>
</html>