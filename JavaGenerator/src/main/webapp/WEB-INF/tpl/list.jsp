<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%&gt;
&lt;%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看</title>
<link href="/static/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>

<h1 class="page-header">${remarks } - 查看</h1>

<!-- <form class="form-inline">
<button type="submit" class="btn btn-default">查找</button>
</form> -->

<a href="building/insert" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>&nbsp;添加</a>
<table class="table table-striped">
<tr>
	<th><input type="checkbox" onchange="toggleSelectAll(this,$('[name=selectRow]'));"/></th>
	
	<c:forEach items="${columns }" var="i">
	<th><c:if test="${!empty i.columnComment }">${i.columnComment }</c:if><c:if test="${empty i.columnComment }">${i.columnName }</c:if></th>
	</c:forEach>
	<th>操作</th>
</tr>
	&lt;c:forEach items="&#36;{data }" var="i">
<tr>
<td><input type="checkbox" checked="checked" name="selectRow"/></td>
	<c:forEach items="${columns }" var="i">
	<td>
		<c:if test="${i.javaType == 'java.util.Date' }">&lt;fmt:formatDate value="&#36;{i.${i.columnName }}" pattern="yyyy-MM-dd HH:mm:ss"/></c:if>
		<c:if test="${i.javaType != 'java.util.Date' }">&lt;c:out value="&#36;{i.${i.columnName }}">&lt;/c:out></c:if>
	</td>
	</c:forEach>
	<td>
		<a class="btn btn-xs btn-link" href="/${genparam.routePath }/detail/&#36;{i.id }">查看详情</a>
		<button class="btn btn-xs btn-link" onclick="del(&#36;{i.id})">删除</button>
	</td>
</tr>
&lt;/c:forEach>
</table>
<div id="pager"></div>
<script type="text/javascript" src="/static/js/jquery.min.js"></script>
<script type="text/javascript" src="/static/laypage/laypage.js"></script>
<script type="text/javascript">
$(function(){
	laypage({
	    cont: "pager",
	    pages: "&#36;{pager.pageCount}", 
	    curr: "&#36;{pager.pageNumber}", 
	    jump: function(e, first){ 
	        if(!first){ 
	            location.href = "?ps=&#36;{pager.pageSize}&pn="+e.curr;
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

function del(id){
	if(confirm('确认删除此记录？'))
	$.post('/${genparam.routePath }/del',{
		id:id
	},function(data){
		if(data){
			alert('操作成功');location.reload();
		}
		else{
			alert('操作失败')
		}
	},'json');
}
</script>
</body>
</html>