package codegen;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.web.SpringBootServletInitializer;
import org.springframework.stereotype.Controller;

@Controller
@SpringBootApplication
public class SampleController extends SpringBootServletInitializer{
	
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(SampleController.class);
	}

	public static void main(String[] args) throws Exception {
		SpringApplication.run(SampleController.class, args);
	}

}
