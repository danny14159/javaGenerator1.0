<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/static/css/bootstrap.min.css"/>
<title>列表页面</title>
</head>
<body>
<form class="form-inline">
  <div class="form-group">
    <label for="">Name</label>
    <input type="text" class="form-control" name="" placeholder="">
  </div>
  <button type="submit" class="btn btn-default">查找</button>
</form>
<table class="table table-striped">
	<tr>
		<th><input type="checkbox" onchange="toggleSelectAll(this,$('[name=selectRow]'));"/></th>
	</tr>
	<c:forEach items="${pager.list }" var="i">
		<tr>
			<td><input type="checkbox" checked="checked" name="selectRow"/></td>
		</tr>
	</c:forEach>
</table>
<div id="pager"></div>
<script type="text/javascript" src="/static/js/jquery.min.js"></script>
</body>
</html>