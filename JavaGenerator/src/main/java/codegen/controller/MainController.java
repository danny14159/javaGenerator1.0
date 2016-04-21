package codegen.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import codegen.bean.GenParam;
import codegen.utils.DbHelper;
import codegen.utils.Strings;
import codegen.utils.SystemUtils;

@RequestMapping("/")
@Controller
public class MainController{
       
	DbHelper db = new DbHelper();
	
	@RequestMapping
	public String service(@ModelAttribute("g") GenParam genParam, HttpServletResponse response,Model model) {
		try{
		String url = "jdbc:mysql://"+genParam.getUrl_host()+":"+genParam.getUrl_port()+"/"+genParam.getUrl_db()+"?characterEncoding=utf8";
		if(Strings.isEmpty(genParam.getUrl_host())){
			return "index";
		}
		
		db.setUrl(url);
		db.setUsername(genParam.getUsername());
		db.setPassword(genParam.getPassword());
		
/*		request.setAttribute("exportPath", exportPath);
		request.setAttribute("package_", package_);
		request.setAttribute("url", url);
		request.setAttribute("username", username);
		request.setAttribute("password", password);
		request.setAttribute("table", table);
		request.setAttribute("pk", pk);
		request.setAttribute("url_host", url_host);
		request.setAttribute("url_port", url_port);
		request.setAttribute("className", className);
		request.setAttribute("url_db", url_db);*/
		
		if(Strings.isBlank(genParam.getClassName())){
			genParam .setClassName(SystemUtils.getClassNameFromTableName(genParam.getTable(), "t"));
		}
		
		if(Strings.isBlank(genParam.getDesktop())){
			genParam.setExportPath(SystemUtils.getDesktopPath());
		}
		
		model.addAttribute("tables", db.getTables());
		model.addAttribute("g", genParam);
		
		if(Strings.isNotBlank(genParam.getTable())){
			model.addAttribute("columns", db.getColumns(genParam.getTable()));
		}
		
		} catch (Exception e) {
			model.addAttribute("exception", e.getMessage());
		}
		return "index";
	}

}
