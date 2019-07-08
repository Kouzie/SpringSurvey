package org.sist.project.controller;

import java.util.List;

import org.sist.project.domain.MemberVO;
import org.sist.project.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
	
	@Autowired
	MemberService service;
	
	@RequestMapping("main")
	public String main(
			@RequestParam(value="pg", defaultValue="1" , required=false) String p_page,
			@RequestParam(value="sort", defaultValue="date" , required=false) String sort,
			@RequestParam(value="type", defaultValue="on", required=false) String type,
			@RequestParam(value="search", required=false) String search,
			Model model
			) throws Exception {
		
		
		List<MemberVO> adminList = service.getAdminList();
		model.addAttribute("adminList", adminList);
		return "survey.index";
	}
	@RequestMapping("login")
	public String login(Model model)
	{
		return "survey.login";
	}
	
	@RequestMapping("readSurvey")
	public String readSurvey(Model model)
	{
		return "survey.readSurvey_on";
	}
}
