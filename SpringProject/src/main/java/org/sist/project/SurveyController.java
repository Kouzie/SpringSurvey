package org.sist.project;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/survey/*")
public class SurveyController {
	
	private static final Logger logger = LoggerFactory.getLogger(SurveyController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	/*@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	*/
	@RequestMapping("main")
	public String main(
			@RequestParam(value="pg", defaultValue="1" , required=false) String p_page,
			@RequestParam(value="sort", defaultValue="date" , required=false) String sort,
			@RequestParam(value="search", required=false) String search,
			Model model
			)
	{
		
		return "survey.index";
	}
}
