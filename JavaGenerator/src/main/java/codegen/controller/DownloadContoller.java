package codegen.controller;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class DownloadContoller{
       
	@RequestMapping("/down")
	@ResponseBody
	public String downloadFile(String content,String path) {
		
        try {
			FileUtils.write(new File(path), content, "utf-8");
			System.out.println("写入文件"+path);
			
			return "写入文件"+path;
		} catch (IOException e) {
			e.printStackTrace();
			
			return e.getMessage();
		}
	}

	
}
