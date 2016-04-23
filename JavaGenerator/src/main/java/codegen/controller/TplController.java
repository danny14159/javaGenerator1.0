package codegen.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import codegen.bean.GenParam;
import codegen.utils.DbHelper;
import codegen.utils.Strings;
import codegen.utils.bean.DataBaseTable;

@Controller
@RequestMapping("/tpl")
public class TplController {
	@Resource
	private HttpServletRequest request;
	
	DbHelper helper = new DbHelper();

	@RequestMapping("/insert")
	public String insertPage(Model model) throws Exception{
		
		GenParam param = MainController.getParam(request);
		helper.initParam(param);
		
		
		if(Strings.isNotBlank(param.getTable())){
			
			DataBaseTable table= helper.getTable(param.getTable());
			model.addAttribute("columns", table.getColumnList());
			model.addAttribute("remarks", table.getTableComment());
			
		}
		
		return "tpl/insert";
	}
	@RequestMapping("/list")
	public String listPage(Model model) throws Exception{
		
		GenParam param = MainController.getParam(request);
		helper.initParam(param);
		
		if(Strings.isNotBlank(param.getTable())){
			
			DataBaseTable table= helper.getTable(param.getTable());
			model.addAttribute("columns", table.getColumnList());
			model.addAttribute("remarks", table.getTableComment());
		}
		
		return "tpl/list";
	}
	
	@RequestMapping("/frame")
	public String frame(Model model){
		
		return "tpl/frame";
	}
	
	@RequestMapping("/controller")
	public String controller(){
		
		return "tpl/controller";
	}
	
	@RequestMapping("/login")
	public String loginPage(){
		
		return "tpl/login";
	}
}
