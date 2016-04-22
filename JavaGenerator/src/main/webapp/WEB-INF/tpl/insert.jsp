<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加</title>
<link href="/static/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>

<form class="form-horizontal">

<c:forEach items="${columns }" var="i">
  <div class="form-group">
    <label for="input${i.columnName }" class="col-sm-2 control-label"><c:if test="${!empty i.columnComment }">
    	${i.columnComment }
    </c:if><c:if test="${empty i.columnComment }">
    	${i.columnName }
    </c:if></label>
    <div class="col-sm-3">
      <input type="text" class="form-control" id="input${i.columnName }" placeholder="${i.columnComment }">
    </div>
  </div>
  </c:forEach>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-primary btn-sm">提交</button>
      <button type="reset" class="btn btn-default btn-sm">重置</button>
    </div>
  </div>
</form>


<script type="text/javascript" src="/static/js/jquery.min.js"></script>
</body>
</html>