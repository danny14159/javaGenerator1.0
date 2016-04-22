package codegen.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.util.WebUtils;

import codegen.bean.GenParam;
import codegen.utils.DbHelper;
import codegen.utils.Strings;
import codegen.utils.SystemUtils;

@RequestMapping("/")
@Controller
public class MainController{
	
	public static final String SES_PARAM="ses.param";
	
	public static GenParam getParam(HttpServletRequest request){
		
		return (GenParam) WebUtils.getSessionAttribute(request, SES_PARAM);
	}
       
	DbHelper db = new DbHelper();
	@Resource
	private HttpServletRequest request;
	
	@RequestMapping
	public String service(@ModelAttribute("g") GenParam genParam, HttpServletResponse response,Model model) {
		try{
		if(Strings.isEmpty(genParam.getUrl_host())){
			return "index";
		}
		
		db.initParam(genParam);
		
		//if(Strings.isBlank(genParam.getClassName())){
			genParam .setClassName(SystemUtils.getClassNameFromTableName(genParam.getTable(), "t"));
		//}
		
		if(Strings.isBlank(genParam.getDesktop())){
			genParam.setExportPath(SystemUtils.getDesktopPath());
		}
		
		model.addAttribute("tables", db.getTables());
		model.addAttribute("g", genParam);
		WebUtils.setSessionAttribute(request,SES_PARAM, genParam);
		
		if(Strings.isNotBlank(genParam.getTable())){
			model.addAttribute("columns", db.getColumns(genParam.getTable()));
		}
		
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("exception", e.getMessage());
		}
		return "index";
	}


}
