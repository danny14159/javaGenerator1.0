package codegen.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import codegen.bean.GenParam;
import codegen.utils.DbHelper;
import codegen.utils.Strings;

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
			
			model.addAttribute("columns", helper.getColumns(param.getTable()));
		}
		
		return "tpl/insert";
	}
	@RequestMapping("/list")
	public String listPage(Model model) throws Exception{
		
		GenParam param = MainController.getParam(request);
		helper.initParam(param);
		
		if(Strings.isNotBlank(param.getTable())){
			
			model.addAttribute("columns", helper.getColumns(param.getTable()));
		}
		
		return "tpl/list";
	}
}
