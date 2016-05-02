<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
package ${genparam.package_ }.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import ${genparam.package_ }.bean.${genparam.className };
import ${genparam.package_ }.mapper.BasicDao;
import ${genparam.package_ }.mapper.${genparam.className }Dao;

@Controller
@RequestMapping("/${genparam.routePath }")
public class ${genparam.className }Controller extends BasicController<${genparam.className }>{
	
	@Resource
	private ${genparam.className }Dao ${genparam.className }Dao;
	
	public static final String PREFIX="${genparam.className }/";

	@Override
	protected String getPrefix() {
		return PREFIX.toLowerCase();
	}

	@Override
	protected BasicDao<${genparam.className }> getDao() {
		return ${genparam.className }Dao;
	}


}
    