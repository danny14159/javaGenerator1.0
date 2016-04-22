<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加</title>
<link href="/static/css/bootstrap.min.css" rel="stylesheet"/>
<style type="text/css">
.error{color:red;}
</style>
</head>
<body>

<h1 class="page-header">${remarks } - 新增</h1>

<form form-ajax class="form-horizontal" id="main-form" action="/${genparam.routePath }/insert">

<c:forEach items="${columns }" var="i">
  <div class="form-group">
    <label for="input${i.columnName }" class="col-sm-2 control-label"><c:if test="${!empty i.columnComment }">
    	${i.columnComment }
    </c:if><c:if test="${empty i.columnComment }">
    	${i.columnName }
    </c:if></label>
    <div class="col-sm-3">
      <input type="text" class="form-control required" id="input${i.columnName }" placeholder="${i.columnComment }">
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
<script type="text/javascript" src="/static/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="/static/js/messages_zh.min.js"></script>
<script type="text/javascript" src="/static/js/form-ajax.js"></script>
<script type="text/javascript">

</script>
</body>
</html>