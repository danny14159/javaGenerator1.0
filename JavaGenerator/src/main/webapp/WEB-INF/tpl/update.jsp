<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%&gt;
&lt;%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改</title>
<link href="/static/css/bootstrap.min.css" rel="stylesheet"/>
<style type="text/css">
.error{color:red;}
</style>
</head>
<body>

<h1 class="page-header">${remarks } - 修改</h1>

<form form-ajax class="form-horizontal" id="main-form" action="/${genparam.routePath }/update" forward="/${genparam.routePath }/">

<c:forEach items="${columns }" var="i">
<div class="col-sm-6">
  <div class="form-group">
    <label for="input${i.columnName }" class="col-sm-4 control-label"><c:if test="${!empty i.columnComment }">
    	${i.columnComment }	
    </c:if><c:if test="${empty i.columnComment }">
    	${i.columnName }
    </c:if></label>
    <div class="col-sm-6">
    <c:if test="${i.javaType == 'java.util.Date' }">
      <input type="text" class="form-control required laydate-icon" id="input${i.columnName }" placeholder="${i.columnComment }" name="${i.columnName }" onclick="laydate()" value="&lt;fmt:formatDate value="&#36;{data.${i.columnName }}" pattern="yyyy-MM-dd"/>">
   </c:if>
   <c:if test="${i.javaType != 'java.util.Date' }">
      <input type="text" class="form-control required" id="input${i.columnName }" placeholder="${i.columnComment }" name="${i.columnName }" value="&#36;{data.${i.columnName }}">
    </c:if>
    </div>
  </div>
  </div>
 </c:forEach>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-primary btn-sm">修改</button>
    </div>
  </div>
</form>


<script type="text/javascript" src="/static/js/jquery.min.js"></script>
<script type="text/javascript" src="/static/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="/static/js/messages_zh.min.js"></script>
<script type="text/javascript" src="/static/js/form-ajax.js"></script>
<script type="text/javascript" src="/static/laydate/laydate.js"></script>
<script type="text/javascript">

</script>
</body>
</html>