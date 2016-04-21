<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加页面</title>
<link href="/static/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>

<form class="form-horizontal">

<c:forEach items="${fieldList }" var="i">
  <div class="form-group">
    <label for="inputEmail3" class="col-sm-2 control-label">Email</label>
    <div class="col-sm-3">
      <input type="email" class="form-control" id="inputEmail3" placeholder="Email">
    </div>
  </div>
  </c:forEach>
</form>


<script type="text/javascript" src="/static/js/jquery.min.js"></script>
</body>
</html>