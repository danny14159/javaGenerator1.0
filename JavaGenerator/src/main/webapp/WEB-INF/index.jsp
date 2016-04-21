<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/static/css/bootstrap.min.css" rel="stylesheet"/>
<title>代码生成器</title>
<style type="text/css">
.tb_props{width:80%;}
#main{padding: 15px;}
#main div.row{margin: 15px 0 0 10px;}
.row label{width: 100px;}
.row input{width: 300px;}
s{color:red;font-weight: bold;text-decoration: none;margin: 3px;}
</style>
</head>
<body>

<h2>Database - Java Code Generator v0.1</h2>

		<!-- <h3>jdbc:mysql://[ip]:3306/[database]?characterEncoding=utf8</h3> -->
		<h4 class="text-danger">${exception }</h4>
<form action="" method="post" id="main" class="form-inline">
	<div class="row">
		<label><s>*</s>数据库Url:</label>
		<input type="hidden" name="url" 
		value="${g.url }" class="required" style="width:700px"
		placeholder="jdbc:mysql://[ip]:[port]/[database]?characterEncoding=utf8"/>
		jdbc:mysql://
		<input type="text" name="url_host" placeholder="host" style="width:300px" value="${g.url_host }"/>:
		<input type="text" name="url_port" placeholder="port" style="width:300px" value="${g.url_port }"/>/
		<input type="text" name="url_db" placeholder="database" style="width:300px" value="${g.url_db }"/>?characterEncoding=utf8
	</div>
	<div class="row">
		<div class="form-group">
			<label><s>*</s>数据库用户名:</label><input type="text" name="username" value="${g.username }" class="required"/>
		</div>
		<div class="form-group">
			<label><s>*</s>数据库密码:</label><input type="password" name="password" value="${g.password }" class="required"/>
		</div>
	</div>
	<div class="row">
		<div class="form-group">
			<label><s>*</s>基础包名:</label><input type="text" name="package_" value="${g.package_ }" class="required" placeholder="如：com.sun"/>
		</div>
		<div class="form-group">
			<label><s></s>实体类名:</label><input type="text" name="className" value="${g.className }" class="required" placeholder="可选，默认不忽略表前缀"/>
		</div>
	</div>
	<div class="row">
		<div class="form-group">
			<label><s></s>路由路径:</label>/<input type="text" name="routePath" value="${routePath }" class="required" placeholder="控制器请求的路由路径"/>
		</div>
		<div class="form-group">
			<label><s>*</s>导出地址:</label><input type="text" name="exportPath" value="${g.exportPath }" class="required"/><button onclick="getDesktopPath()" class="btn btn-primary btn-xs">桌面</button>
		</div>
	</div>
	<div class="row">
		<div class="form-group">
			<label><s>*</s>主键:</label><input type="text" name="pk" value="${g.pk }" class="required"/>
		</div>
	</div>

	<div class="row">
		<button type="submit" class="btn btn-primary btn-xs">获取数据表</button>
		<button type="submit" class="btn btn-primary btn-xs" onclick="$('#main').submit();">获取字段</button>
		<select id="tables" name="table" onchange="$('#main').submit();">
			<c:forEach items="${tables }" var="i">
				<option 
					<c:if test="${param.table eq i.tableName }">selected="selected" </c:if>
				value="${i.tableName }">${i.tableName }[${i.tableComment }]</option>
			</c:forEach>
		</select>
	</div>
	
	<div class="row">
		<button type="button" class="btn btn-warning btn-xs" onclick="generateBean()">生成java bean</button>
		<button type="button" class="btn btn-danger btn-xs" onclick="generateDao();">生成dao</button>
		<!-- <button type="button" class="btn btn-default btn-xs" onclick="generateDao();">生成controller</button> -->
		<button type="button" class="btn btn-info btn-xs">生成添加页面</button>
		<button type="button" class="btn btn-info btn-xs" onclick="generateListPage()">生成查询页面</button>
		<button type="button" class="btn btn-info btn-xs">生成修改页面</button>
		<button type="button" class="btn btn-default btn-xs">生成全套</button>
		<button type="button" class="btn btn-default btn-xs" onclick="geniBatisXml();">生成ibatis XML文件</button>
	</div>

	<table id="tb_props" class="table table-bordered table-striped">
		<thead>
			<tr>
				<th width="15%">字段名称</th>  
				<th width="15%">字段类型</th>
				<th width="10%">java类型</th>
				<th>字段注释</th>
				<th width="10%"><input type="checkbox" onchange="toggleSelectAll(this,$('[name=selectFieldShow]'));" checked="checked"/>显示</th>
				<th width="10%"><input type="checkbox" onchange="toggleSelectAll(this,$('[name=selectFieldFindby]'));"/>查找</th>
				<th width="10%"><input type="checkbox" onchange="toggleSelectAll(this,$('[name=selectFieldAdd]'));" checked="checked"/>插入</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${columns }" var="i">
			<tr>
				<td>${i.columnName }</th>
				<td>[${i.sqlType}]<span>${i.sqlTypeName }</span></th>
				<td>${i.javaType }</th>
				<td>${i.columnComment }</th>
				<td><input type="checkbox" checked="checked" name="selectFieldShow"/></td>
				<td><input type="checkbox" name="selectFieldFindby"/></td>
				<td><input type="checkbox" checked="checked" name="selectFieldAdd"/></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<input type="hidden" name="desktop" />
</form>

<script type="text/javascript" src="/static/js/laytpl.js"></script>
<script type="text/javascript" src="/static/js/jquery.min.js"></script>
<script type="text/javascript" src="/static/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="/static/js/messages_zh.min.js"></script>
<script type="text/javascript">  
String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) {  
    if (!RegExp.prototype.isPrototypeOf(reallyDo)) {  
        return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi": "g")), replaceWith);  
    } else {  
        return this.replace(reallyDo, replaceWith);  
    }  
}  
</script> 

<script type="text/html" id="ibatisTpl"><?xml version="1.0" encoding="UTF-8" ?>\n
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">\n
<mapper namespace="{{d.namespace}}">\n
	<insert id="insert" parameterType="{{d.name}}">\n
		insert into {{d.tbname}}({{d.insertCols}}) values({{d.insertVals}});\n
	</insert>\n
	<delete id="delete" parameterType="{{d.name}}">\n
		update {{d.tbname}} set delete_state=1\n
		<where>\n
			{{d.pk}}\n
			{{# for(var i = 0,len=d.deleteCon.length;i<len;i++){ }}
				<if test="{{d.deleteCon[i]}}!=null">and {{d.deleteCon[i]}}=#{ {{d.deleteCon[i]}} }</if>\n
			{{# } }}
		</where>\n
	</delete>\n
	<update id="update" parameterType="{{d.name}}">\n
		update {{d.tbname}}\n
		<set>\n
			{{# for(var i = 0,len=d.updateField.length;i<len;i++){ }}
				<if test="{{d.updateField[i]}}!=null">{{d.updateField[i]}}=#{ {{d.updateField[i]}} },</if>\n
			{{# } }}
		</set>\n
		<where>\n
			{{d.pk}}\n
			{{# for(var i = 0,len=d.updateCon.length;i<len;i++){ }}
				<if test="{{d.updateCon[i]}}!=null">and {{d.updateCon[i]}}=#{ {{d.updateCon[i]}} }</if>\n
			{{# } }}
		</where>\n
	</update>\n
	<select id="list" resultType="{{d.name}}" parameterType="{{d.name}}">\n
		select {{d.insertCols}} from {{d.tbname}}\n
		<where>\n
			{{# for(var i = 0,len=d.selectCon.length;i<len;i++){ }}
				<if test="{{d.selectCon[i]}}!=null">and {{d.selectCon[i]}}{{d.selectOpt[i]}}#{ {{d.selectCon[i]}} }</if>\n
			{{# } }}
		</where>\n
	</select>\n
	<select id="listByPage" resultType="{{d.name}}" parameterType="{{d.name}}">\n
		select {{d.insertCols}} from {{d.tbname}}\n
		<where>\n
			{{# for(var i = 0,len=d.selectCon.length;i<len;i++){ }}
				<if test="{{d.selectCon[i]}}!=null">and {{d.selectCon[i]}}{{d.selectOpt[i]}}#{ {{d.selectCon[i]}} }</if>\n
			{{# } }}
		</where>\n
		limit #{offset},#{rows}\n
	</select>\n
	<select id="load" resultType="{{d.name}}" parameterType="{{d.name}}">\n
		select {{d.insertCols}} from {{d.tbname}}\n
		<where>\n
			{{# for(var i = 0,len=d.selectCon.length;i<len;i++){ }}
				<if test="{{d.selectCon[i]}}!=null">and {{d.selectCon[i]}}{{d.selectOpt[i]}}#{ {{d.selectCon[i]}} }</if>\n
			{{# } }}
		</where>\n
		limit 0,1\n
	</select>\n
	<select id="count" resultType="int" parameterType="{{d.name}}">\n
		select count(1) from {{d.tbname}}\n
		<where>\n
			{{# for(var i = 0,len=d.selectCon.length;i<len;i++){ }}
				<if test="{{d.selectCon[i]}}!=null">and {{d.selectCon[i]}} {{ d.selectOpt[i] }} #{ {{d.selectCon[i]}} }</if>\n
			{{# } }}
		</where>\n
	</select>\n
</mapper>\n
</script>


<script type="text/html" id="tplJavabean">
package {{package}};
</script>
<script type="text/javascript">
$(function(){
/* 	$('#main').submit(function(){
		$(this).find('.required').each(function(){
			if(!$(this).val()){
				alert($(this).prev().html()+'不能为空');
				return false;
			}
		});
	}); */
})
function gettext(id){
	var ret = $('#'+id).val();
	ret = ret || $('[name='+id+']').val();
	ret = ret || "";
	return ret;
}
function exportFile(pkg,name,filetype,text,outpath){
	var t=text;
	
	//处理转义
	t = t.replaceAll('&lt;','<');
	t = t.replaceAll('&gt;','>');
	t = t.replaceAll('&amp;','$');
	
	/*利用activeX向本地输出文件*/
	var packs=pkg.replace(/(\.)/g, '\\');
	var folders=pkg.split('.');
	
	var filepath=outpath+'\\'+packs+'\\'+name+'.'+filetype;
	
	$.post('/down',{
		path:filepath,
		content:t
	},function(){
		alert('成功');
	},'json');
	
	return;
	
	/* var fso = new ActiveXObject("Scripting.FileSystemObject");   //加载控件
	var utf8Enc = new ActiveXObject("Utf8Lib.Utf8Enc"); //编码控件

	var _path="";
		for(var i in folders){
			_path+=folders[i]+'\\';
			try{ fso.CreateFolder(_path);
			}catch(e){console.log(e);}
		}
	
	var dstFile; 
	try{
		dstFile =  fso.OpenTextFile(filepath, 2, true);
	}
	catch(e){
		console.log(e,'opening failed!attempt creating.');dstFile = fso.CreateTextFile(filepath,true); //true for overwrite
	}
	for(var i = 0;i<t.length;i++){
		var ch=t.charAt(i);
		if(ch=='\t')dstFile.Write('    ');
		else if(ch=='\n')dstFile.WriteBlankLines(1);
		else dstFile.BinaryWrite(utf8Enc.UnicodeToUtf8(strContent));
		
	}
	console.log('success:filepath=',filepath);
	dstFile.Close(); */
}
function getDesktopPath(){
	$('input[name=desktop]').val('true');
	$('#main').submit();
}

//格式[[字段名称，字段类型，java类型，字段注释],...]
function retrievePojoObject(type){
	var arr = [];
	$('#main tbody tr').each(function(){
		var obj = [];
		obj.push($(this).children('td:eq(0)').html().trim());
		obj.push($(this).find('td:eq(1)>span').html().trim());
		obj.push($(this).children('td:eq(2)').html().trim());
		obj.push($(this).children('td:eq(3)').html().trim());
		obj.push($(this).find('td:eq(4) input').get(0).checked);
		obj.push($(this).find('td:eq(5) input').get(0).checked);
		obj.push($(this).find('td:eq(6) input').get(0).checked);
		if(type && obj[type] || !type)
			arr.push(obj);
	});
	return arr;
}

function firstCharToLowerCase(str){
	return str.charAt(0).toLowerCase() + str.substring(1);
}
function firstCharToUpperCase(str){
	return str.charAt(0).toUpperCase() + str.substring(1);
}

function genGetterSetter(className,beanName){
	var ret = '\n\tpublic void set'+firstCharToUpperCase(beanName)+'('+className+' '+beanName+'){\n\t\tthis.'+beanName+'='+beanName+';\n\t}\n\n';
	ret += '\tpublic '+className+' get'+firstCharToUpperCase(beanName)+'(){\n\t\treturn this.'+beanName+';\n\t}\n';
	return ret;
}

function generateBean(){
	
	var t="";
	t+="package "+gettext("package_")+".bean;\n";
	t+="/**"+gettext('desc')+"\n * @author "+gettext('author')+"\n *\n */\n";
	t+="public class "+gettext('className')+' '+gettext('extends')+" {\n";

	var arr=retrievePojoObject();
	for(var p in arr){
		t+="\n\t/**\n\t * "+arr[p][3]+"\n\t */\n";
		if(arr[p][2] == 'java.util.Date'){
			t+='\t@org.springframework.format.annotation.DateTimeFormat(pattern="yyyy-dd-MM HH:mm:ss")\n'
		}
		t+="\tprivate "+arr[p][2]+' '+arr[p][0]+';\n';
	}
	for(var p in arr){
		t+=genGetterSetter(arr[p][2],arr[p][0]);
	}

	t+="\n}";
	console.log(t);
	
	exportFile(gettext('package_')+'.bean', gettext('className'), 'java', t,gettext('exportPath'));
	
	return t;
}
function generateDao(){
	var t = "package "+gettext('package_')+'.dao;\n';
	t+="import org.springframework.stereotype.Repository;\n";
	t+="import "+gettext('package_')+'.bean.'+gettext('className')+'\n';
	t+="/**"+gettext('desc')+"\n * @author "+gettext('author')+"\n *\n */\n";
	t+='@Repository\n';
	t+='public class '+gettext('className')+'Dao extends BasicDao<'+gettext('className')+'> {\n\n';
	t+='\tpublic '+gettext('className')+'Dao() {\n\t\tsuper("'+gettext('table')+'", '+gettext('className')+'.class);\n\t}\n';
	
	//处理findBy
	var findby = retrievePojoObject(5);
	for(var i in findby){
		var item=findby[i];
		t+='\tpublic Pager<'+gettext('className')+'> findPageBy'+firstCharToUpperCase(item[0])+' ('+item[2]+' val,int ps,int pn){\n\t\treturn super.listByPage(Cnd.where("'+item[0]+'","=",val),ps,pn);\n\t}\n'
		t+='\tpublic java.util.List<'+gettext('className')+'> findBy'+firstCharToUpperCase(item[0])+' ('+item[2]+' val){\n\t\treturn super.list(Cnd.where("'+item[0]+'","=",val));\n\t}\n'
	}
	
	t+='\n}';
	console.log(t);
	
	exportFile(gettext('package_')+'.dao', gettext('className'), 'java', t,gettext('exportPath'));
	
	return t;
}
var topBody='&lt;%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%&gt;\n\
&lt;%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%&gt;\n\
&lt;%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>\n\
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">\n\
<html>\n\
<head>\n\
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">\n\
<title>列表页面</title>\n\
</head>\n\
<body>\n',
bottomBody='</body>\n\
</html>';
		
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

function generateListPage(){
	var list = retrievePojoObject(4),findBy = retrievePojoObject(5);
	var t = topBody;
	t += '<form class="form-inline">\n';
	
	for(var i in findBy){
  t+='<div class="form-group">\n\
    <label for="">'+findBy[i][3]+'：</label>\n\
    <input type="text" class="form-control" name="'+findBy[i][0]+'" placeholder="" value="&amp;{data.'+findBy[i][0]+'}">\n\
  </div>\n';
}
  
  t+='<button type="submit" class="btn btn-default">查找</button>\n\
</form>';
	t += '<table class="table table-striped">\n\
<tr>\n\t<th><input type="checkbox" onchange="toggleSelectAll(this,$(\'[name=selectRow]\'));"/></th>\n';
		for(var i in list){
			t+= '\t<th>'+(list[i][3]||list[i][0])+'</th>\n';
		}
	t+='</tr>\n\
	&lt;c:forEach items="&amp;{pager.list }" var="i">\n\
<tr>\n<td><input type="checkbox" checked="checked" name="selectRow"/></td>\n';
		for(var i in list){
			t+='\t<td>';
			if(list[i][2] == "java.util.Date"){
				t+='&lt;fmt:formatDate value="&amp;{i.'+list[i][0]+'}" pattern="yyyy-MM-dd HH:mm:ss"/>';
			}
			else{
				t+='&lt;c:out value="'+'&amp;{i.'+list[i][0]+'}'+'">&lt;/c:out>';
			}
			t+='</td>\n';
		}
		t+='</tr>\n\
&lt;/c:forEach>\n\
</table>\n\
<div id="pager"></div>\n\
<script type="text/javascript" src="/static/js/jquery.min.js">&lt;/script&gt;\n\
<script type="text/javascript" src="/static/laypage/laypage.js">&lt;/script&gt;\n\
<script type="text/javascript">\n\
$(function(){\n\
	laypage({\n\
	    cont: "pager",\n\
	    pages: "&amp;{pager.pageCount}", \n\
	    curr: "&amp;{pager.pageNumber}", \n\
	    jump: function(e, first){ \n\
	        if(!first){ \n\
	            location.href = "?ps=&amp;{pager.pageSize}&amp;pn="+e.curr;\n\
	        }\n\
	    }\n\
	});\n\
})\n\
function toggleSelectAll(self,$sel){\n\
	if(self.checked)\n\
		$sel.each(function(){\n\
			if(!this.checked) $(this).click();\n\
		});\n\
	else{\n\
		$sel.each(function(){\n\
			if(this.checked) $(this).click();\n\
		});\n\
	}\n\
}\n&lt;/script&gt;\n';
	
	t+=bottomBody;
	console.log(t);
	
	exportFile(gettext('package_')+'.front.'+firstCharToLowerCase(gettext('className')), 'list','jsp', t,gettext('exportPath'));
}

function geniBatisXml(){
	//$('#namespace').val(gettext('package')+'.service.'+gettext('name')+'Service');
	
	var records=retrievePojoObject();
	
	$('input[id]').each(function(){
		$(this).attr('name',$(this).attr('id'));
	});
	var data = {};
	data.insertCols="";
	data.insertVals="";
	data.deleteCon=[];
	data.updateField=[];
	data.updateCon=[];
	data.selectCon=[];
	data.selectOpt=[];
	
	var insertField=[];
	var insertValues=[];
	
	var apk=[$('[name=pk]').val()];
	
	for(var i in records){
		var r=records[i];
		if(r[6]) {insertField.push(r[0]);insertValues.push('#{'+r[0]+'}')};
		if(r[6] && r[0]!=apk[0]) data.deleteCon.push(r[0]);
		if(r[6]) data.updateField.push(r[0]);
		if(r[6] && r[0]!=apk[0]) data.updateCon.push(r[0]);
		if(r[4]) {
			data.selectCon.push(r[0]);data.selectOpt.push('=');
		}
	}
	data.insertCols=insertField.join(",");
	data.insertVals=insertValues.join(",");
	

	for(var i in apk){
		apk[i]=apk[i]+'=#{'+apk[i]+'}';
	}
	data.pk=apk.join(' and ');
	data.tbname = $('#tables').val();
	data.namespace = $('[name=package_]').val()+'.mapper.'+gettext('className')+'Dao';
	data.name = $('[name=package_]').val() + '.bean.'+$('[name=className]').val();
	data['package'] = gettext('package_');
	console.log(data);
	
	
	laytpl($('#ibatisTpl').html()).render(data,function(html){
		html = html.replace(/(\\n)/g,'\n');
		console.log(html);
		exportFile(data['package']+'.service.mapper', gettext('className')+'Mapper', 'xml', html,gettext('exportPath'));
		
		var mapres=(data['package']+'.service.mapper').replace(/(\.)/g, '/')+'/'+data.name+'Mapper.xml';
		console.log("mapper:<mapper resource=\""+mapres+"\"></mapper>")
	});

}
//查询页面1.findBy,2.显示字字段，3.批量操作
</script>
</body>
</html>