package codegen.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 */
@Controller
public class DownloadContoller{
       
	@RequestMapping("/down")
	public void downloadFile(String content,String path,HttpServletResponse response) {
		
        try {
			FileUtils.write(new File(path), content, "utf-8");
			response.getWriter().print(true);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	
}
