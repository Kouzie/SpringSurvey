package org.sist.project.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.sist.project.domain.MemberVO;
import org.sist.project.domain.PageMaker;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SurveyVO;
import org.sist.project.service.MemberService;
import org.sist.project.service.SurveyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/survey/*")
public class SurveyController {
	
	private static final Logger logger = LoggerFactory.getLogger(SurveyController.class);

	@Autowired
	MemberService memberService;
	@Autowired
	SurveyService surveyService;
	
	@RequestMapping("main")
	public String main(
			/*@RequestParam(value="pg", defaultValue="1" , required=false) String pg,
			@RequestParam(value="perPageNum", defaultValue="10" , required=false) String perPageNum,
			@RequestParam(value="sort", defaultValue="date" , required=false) String sort,
			@RequestParam(value="progressing", defaultValue="1", required=false) int progressing,
			@RequestParam(value="search", required=false) String search,*/
			@ModelAttribute("cri") SearchCriteria cri,
			Model model
			) throws Exception {
		
		List<SurveyVO> surveyList = surveyService.getSurveyList(cri);
		model.addAttribute("surveyList", surveyList);
		
		PageMaker pageMaker = surveyService.getPagination(cri);
		model.addAttribute("pageMaker", pageMaker);
		
		List<MemberVO> adminList = memberService.getAdminList();
		model.addAttribute("adminList", adminList);
		return "survey.index";
	}
	
	@RequestMapping("login")
	public String login(Model model) throws Exception {
		return "survey.login";
	}
	
	@RequestMapping(value="join", method = RequestMethod.GET) 
	public String joinGET(Model model) throws Exception {
		return "survey.join";
	}
	
	@RequestMapping(value="join", method = RequestMethod.POST)
	public String joinPOST(
			@RequestParam("image") MultipartFile multipartFile,
			@RequestParam("username") String username, 
			@RequestParam("password") String password, 
			@RequestParam("password2") String password2, 
			@RequestParam("name") String name, 
			@RequestParam("birth") String birth, 
			@RequestParam("gender") String gender, 
			HttpServletRequest request,
			Model model) throws Exception
	{
		String realPath = request.getRealPath("/resources/img");
		MemberVO member = new MemberVO();
		member.setUsername(username);
		member.setPassword(password);
		member.setName(name);
		String pattern = "yyyy-MM-dd";
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		member.setBirth(sdf.parse(birth));
		member.setGender(gender.equals("male") ? 1 : 0);
		memberService.addMember(member ,multipartFile, realPath);
		return "redirect:/survey/main";
	}
	
	@RequestMapping("readSurvey")
	public String readSurvey(Model model) throws Exception {
		return "survey.readSurvey_on";
	}
	
	//
	@RequestMapping("insertSurvey")
	public String insert_survey() throws Exception {
		System.out.println("insertSurvey페이지 뿌려지는 함수");
		return "insertSurvey";
	}
}
