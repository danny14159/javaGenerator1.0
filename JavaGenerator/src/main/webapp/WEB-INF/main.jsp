<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>java代码生成器</title>
<style type="text/css">
body{
	font-family: 'Courier New'!important;
}
table,td,th{
	border:1px solid #eee;
}
.req{
	color:red;
}
</style>
</head>
<body>
<form id="fmall">
<div>
	<label class="req">destination folder(terminated by \):</label>
	<input type="text" id="folder" size="50"/>
</div>
<div>
	<label>import:</label>
	<textarea id="import" cols="40" rows="6" name="import"></textarea>
</div>
<div>
	[xml]<label class="req">package:</label>
	<input type="text" id="package" name="package" size="50"/>
</div>
<div>
	[xml]<label class="req">class name:</label>
	<input type="text" id="name"/>
	<label>extends:</label>
	<input type="text" id="extends"/>
</div>
<div>
	<label>description:</label>
	<input type="text" id="desc"/>
</div>
<div>
	<label>author:</label>
	<input type="text" id="author"/>
</div>
<div>
	[xml]<label>namespace:</label>
	<input type="text" id="namespace" size="50"/>
</div>
<div>
	<label>逻辑删除:</label>
	<input type="checkbox" id="logic"/>
</div>
<div>
	[xml]<label class="req">primary key(split by ;):</label>
	<input type="text" id="pk"/>
</div>
<div>
	[xml]<label>table name:</label>
	<input type="text" id="tbname"/>
</div>

<div>
	<label>properties:</label>
	<button onclick="return addprop();">ADD+</button>
	<table id="tb_props">
		<thead><tr><th>remark</th><th>type</th><th>variable</th>  <th>插入字段</th><th>删除条件</th><th>更新字段</th><th>更新条件</th><th>查询条件</th><th>查询符号</th>  <th>opt</th></tr></thead>
		<tbody></tbody>
	</table>
	<h1>注意：主键无需作为删除条件和更新条件！</h1>
	<!-- <textarea rows="20" cols="20" id="prop">a b;c d</textarea> -->
</div>
</form>
<!-- <a onclick="downloadFile(this,gettext('name')+'.java',generate())">generate</a>-->
<button onclick="generateBean();">generate java bean</button>
<button onclick="generateAll();">generate all</button>
<button onclick="generateXml();">generate mybatis xml</button>
<button onclick="generateInterf();">generate service interface</button>
<button onclick="generateImpl();">generate service impl</button>
<button onclick="generateModule();">generate controller</button>
<button onclick="reset();">reset properties</button>
<button onclick="saveSettings();">save settings</button>
<div id="out"></div>

<script type="text/javascript" src="laytpl.js"></script>
<script id="fields" type="text/html">
<td><input type='text'/></td><td><input type='text'/><select><option>String</option><option>Character</option><option>Integer</option><option>Date</option><option>Double</option></select></td><td><input type='text'/></td>
	<td><input type="checkbox"></td>
	<td><input type="checkbox"></td>
	<td><input type="checkbox"></td>
	<td><input type="checkbox"></td>
	<td><input type="checkbox"></td>
	<td><select>
	<option>=</option>
	<option>&gt;</option>
	<option>&lt;</option>
	<option>&gt;=</option>
	<option>&lt;=</option>
	<option>in</option>
	</select></td>
<td><a href="javascript:;" onclick="removeTr(this);">x</a></td>
</script>

<script type="text/html" id="generateXml"><?xml version="1.0" encoding="UTF-8" ?>\n
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">\n
<mapper namespace="{{d.namespace}}">\n
	<insert id="insert" parameterType="{{d.name}}">\n
		insert into {{d.tbname}}({{d.insertCols}}) values({{d.insertVals}});\n
	</insert>\n
	<delete id="delete" parameterType="hashmap">\n
		update {{d.tbname}} set deleted='Y'\n
		<where>\n
			{{d.pk}}\n
			{{# for(var i = 0,len=d.deleteCon.length;i<len;i++){ }}
				<if test="{{d.deleteCon[i]}}!=null">and {{d.deleteCon[i]}}=#{ {{d.deleteCon[i]}} }</if>\n
			{{# } }}
		</where>\n
	</delete>\n
	<update id="update" parameterType="hashmap">\n
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
	<select id="list" resultType="{{d.name}}" parameterType="hashmap">\n
		select * from {{d.tbname}}\n
		<where>\n
			{{# for(var i = 0,len=d.selectCon.length;i<len;i++){ }}
				<if test="{{d.selectCon[i]}}!=null">and {{d.selectCon[i]}}{{d.selectOpt[i]}}#{ {{d.selectCon[i]}} }</if>\n
			{{# } }}
		</where>\n
	</select>\n
	<select id="listByPage" resultType="{{d.name}}" parameterType="hashmap">\n
		select * from {{d.tbname}}\n
		<where>\n
			{{# for(var i = 0,len=d.selectCon.length;i<len;i++){ }}
				<if test="{{d.selectCon[i]}}!=null">and {{d.selectCon[i]}}{{d.selectOpt[i]}}#{ {{d.selectCon[i]}} }</if>\n
			{{# } }}
		</where>\n
		limit #{offset},#{rows}\n
	</select>\n
	<select id="load" resultType="{{d.name}}" parameterType="hashmap">\n
		select * from {{d.tbname}}\n
		<where>\n
			{{# for(var i = 0,len=d.selectCon.length;i<len;i++){ }}
				<if test="{{d.selectCon[i]}}!=null">and {{d.selectCon[i]}}{{d.selectOpt[i]}}#{ {{d.selectCon[i]}} }</if>\n
			{{# } }}
		</where>\n
		limit 0,1\n
	</select>\n
	<select id="count" resultType="int" parameterType="hashmap">\n
		select count(*) from {{d.tbname}}\n
		<where>\n
			{{# for(var i = 0,len=d.selectCon.length;i<len;i++){ }}
				<if test="{{d.selectCon[i]}}!=null">and {{d.selectCon[i]}} {{ d.selectOpt[i] }} #{ {{d.selectCon[i]}} }</if>\n
			{{# } }}
		</where>\n
	</select>\n
</mapper>\n
</script>

<script type="text/javascript" src="jquery-2.1.0.min.js"></script>
<script type="text/html" id="tplcontroller">
\n@Controller\n@RequestMapping("/xxx")\npublic class {{d.classname}} extends BasicModule<{{d.beanname}}>{\n\n\t@Autowired\n\tprivate {{d.servicename}} {{d.serviceobj}};\n\n\t@Override\n\tprotected BaseService<{{d.beanname}}> getService() {\n\t\treturn {{d.serviceobj}};\n\t}\n\n}
</script>
<script type="text/javascript">
jQuery.prototype.serializeObject=function(){  
    var obj=new Object();  
    $.each(this.serializeArray(),function(index,param){  
        if(!(param.name in obj)){  
            obj[param.name]=param.value;  
        }  
    });  
    return obj;  
}; 

function advanced(){
	
}
function reset(){
	$('#tb_props tr:gt(0)').remove();
}
function removeTr(a){
	$(a).closest('tr').hide(200,function(){
		$(this).remove();
	});
}

function addprop(){
	var tr=$('<tr>');
	tr.html($('#fields').html());
	$('#tb_props tbody').append(tr);
	return false;
}

function gettext(id){
	return document.getElementById(id).value;
}
/**
 * 
 */
function exportFile(pkg,name,filetype,text){
	var t=text;
	/*利用activeX向本地输出文件*/
	var packs=pkg.replace(/(\.)/g, '\\');
	var folders=pkg.split('.');
	
	var desktop=$('#folder').val();
	var filepath=desktop+packs+'\\'+name+'.'+filetype;
	
	var fso = new ActiveXObject("Scripting.FileSystemObject");   //加载控件

	var _path="";
		for(var i in folders){
			_path+=folders[i]+'\\';
			try{ fso.CreateFolder(_path);
			}catch(e){console.log(e);}
		}
	
	console.log('filepath=',filepath);
	var dstFile; 
	try{
		dstFile =  fso.OpenTextFile(filepath, 2, true);
	}
	catch(e){
		console.log(e,'opening failed!attempt creating.');dstFile = fso.CreateTextFile(filepath,true);
	}
	for(var i = 0;i<t.length;i++){
		var ch=t.charAt(i);
		if(ch=='\t')dstFile.Write('    ');
		else if(ch=='\n')dstFile.WriteBlankLines(1);
		else dstFile.Write(ch);
		
	}
	dstFile.Close();
}
function generateBean(){
	
	var t="";
	t+=gettext('import')+'\n';
	t+="package "+gettext("package")+".bean;\n";
	t+="/**"+gettext('desc')+"\n * @author "+gettext('author')+"\n *\n */\n";
	t+="public class "+gettext('name')+' '+gettext('extends')+" {\n";

	$('#tb_props tr:gt(0)').each(function(){
		var tds=$(this).find('td');
		var prop=[];
		tds.each(function(i){
			if(i==1 && !$(this).children('input').val()){
				prop.push($(this).children('select').val());
			}else
				prop.push($(this).children('input').val());
		});
		t+="\n\t/**\n\t * "+prop[0]+"\n\t */\n\tprivate "+prop[1]+' '+prop[2]+';\n';
	});

	t+="\n}";
	console.log(t);
	
	exportFile(gettext('package')+'.bean', gettext('name'), 'java', t);
	
	return t;
}
function downloadFile(aLink, fileName, content){
    aLink.download = fileName;
    aLink.href = "data://text/plain," + content;
}
function generateXml(){
	$('#namespace').val(gettext('package')+'.service.'+gettext('name')+'Service');
	
	var records=[];
	$('#tb_props tr:gt(0)').each(function(){
		var tds=$(this).find('td');
		var prop=[];
		tds.each(function(i){
			if(i==1 && !$(this).children('input').val()){
				prop.push($(this).children('select').val());
			}else
				prop.push($(this).children('input[type="text"]').val()||$(this).children('select').val() || $(this).children('input[type="checkbox"]').is(':checked'));
		});
		records.push(prop);
	});
	console.log(records);
	
	$('input[id]').each(function(){
		$(this).attr('name',$(this).attr('id'));
	});
	var data = $('#fmall').serializeObject();
	data.insertCols="";
	data.insertVals="";
	data.deleteCon=[];
	data.updateField=[];
	data.updateCon=[];
	data.selectCon=[];
	data.selectOpt=[];
	
	var insertField=[];
	var insertValues=[];
	
	for(var i in records){
		var r=records[i];
		if(r[3]) {insertField.push(r[2]);insertValues.push('#{'+r[2]+'}')}
		if(r[4]) data.deleteCon.push(r[2]);
		if(r[5]) data.updateField.push(r[2]);
		if(r[6]) data.updateCon.push(r[2]);
		if(r[7]) {
			data.selectCon.push(r[2]);data.selectOpt.push(r[8]);
		}
	}
	data.insertCols=insertField.join(",");
	data.insertVals=insertValues.join(",");
	
	var apk=data.pk.split(';');
	for(var i in apk){
		apk[i]=apk[i]+'=#{'+apk[i]+'}';
	}
	data.pk=apk.join(' and ');
	
	console.log(data);
	
	
	laytpl($('#generateXml').html()).render(data,function(html){
		html = html.replace(/(\\n)/g,'\n');
		console.log(html);
		exportFile(data['package']+'.service.mapper', data.name+'Mapper', 'xml', html);
		
		var mapres=(data['package']+'.service.mapper').replace(/(\.)/g, '/')+'/'+data.name+'Mapper.xml';
		console.log("mapper:<mapper resource=\""+mapres+"\"></mapper>")
	});
}
function generateInterf(){
	//生成接口文件
	var packagename=gettext('package')+'.service';
	var interfname=gettext('name')+'Service';
	
	var t="package "+packagename+';\n';
	t+='public interface '+interfname+' extends BaseService<'+gettext('name')+'>{\n\n}';
	
	
	console.log(t);
	exportFile(packagename, interfname, 'java', t);
}

function generateImpl(){
	
	var packagename=gettext('package')+'.service.impl';
	var classname=gettext('name')+'ServiceImpl';
	var interfname=gettext('name')+'Service';
	
	var t="package "+packagename+';\n';
	t+='public class '+classname+' extends BaseServiceImpl<'+gettext('name')+'> implements '+interfname+'{\n\t{\n\t\tsuper.interf = '+interfname+'.class;\n\t}\n\n}';

	console.log(t);
	exportFile(packagename, classname, 'java', t);
}
function generateModule(){
	var interfname=gettext('name')+'Service';
	var serviceObj = interfname.charAt(0).toLowerCase() + interfname.substring(1);
	var data={
			classname:gettext('name')+'Module',
			beanname:gettext('name'),
			servicename:interfname,
			serviceobj:serviceObj
	}

	laytpl($('#tplcontroller').html()).render(data,function(html){
		html = html.replace(/(\\n)/g,'\n');
		html = html.replace(/(\\t)/g,'\t');
		var packagename=gettext('package')+'.module';
		html='package '+packagename+';'+html;
		console.log(html);
		exportFile(packagename, gettext('name')+'Module', 'java', html);
	});
	
}
function generateAll(){
	
	$('#tbname').val('tb_'+gettext('name').toLowerCase());
	generateBean();
	generateXml();
	generateInterf();
	generateModule();
}
function saveSettings(){
}
</script>
</body>
</html>