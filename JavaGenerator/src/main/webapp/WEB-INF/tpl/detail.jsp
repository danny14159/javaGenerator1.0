<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%&gt;
&lt;%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>详情</title>
<link href="/static/css/bootstrap.min.css" rel="stylesheet"/>
<style type="text/css">
.error{color:red;}.col-sm-6{margin: 5px 0}
</style>
</head>
<body>

<h1 class="page-header">${remarks } - 详情<button onclick="history.go(-1)" class="btn btn-default btn-xs">返回&lt;&lt;</button></h1>


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
    	&lt;fmt:formatDate value="&#36;{data.${i.columnName }}" pattern="yyyy-MM-dd"/>
   </c:if>
   <c:if test="${i.javaType != 'java.util.Date' }">
    	&lt;c:out value="&#36;{data.${i.columnName } }">&lt;/c:out>
    </c:if>
    </div>
  </div>
  </div>
 </c:forEach>

<script type="text/javascript" src="/static/js/jquery.min.js"></script>
<script type="text/javascript" src="/static/laydate/laydate.js"></script>
<script type="text/javascript">

</script>
</body>
</html>