package org.sist.project.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.sist.project.domain.ErrorMessage;
import org.sist.project.domain.MemberVO;
import org.sist.project.domain.PageMaker;
import org.sist.project.domain.ReplyVO;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SurveyItemVO;
import org.sist.project.domain.SurveyVO;
import org.sist.project.domain.SurveyWithDatasetVO;
import org.sist.project.domain.SurveyWithItemVO;
import org.sist.project.service.MemberService;
import org.sist.project.service.SurveyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;

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
			RedirectAttributes rttr) throws Exception
	{
		String realPath = request.getRealPath("/resources/img");
		MemberVO member = new MemberVO();
		member.setUsername(username);
		member.setPassword(password);
		member.setName(name);
		member.setGender(gender.equals("male") ? 1 : 0);
		try {
			String pattern = "yyyy-MM-dd";
			SimpleDateFormat sdf = new SimpleDateFormat(pattern);
			member.setBirth(sdf.parse(birth));
			ErrorMessage errorMessage = member.checkValid();
			if (errorMessage != null) {
				rttr.addAttribute("errorMessage", errorMessage);
				return "redirect:/survey/join";
			}
			memberService.addMember(member ,multipartFile, realPath);
		} catch (DuplicateKeyException e) {
			rttr.addAttribute("errorMessage", new ErrorMessage(100, "중복된 아이디입니다"));
			return "redirect:/survey/join";
		} catch (IllegalArgumentException e) {
			rttr.addAttribute("errorMessage", new ErrorMessage(105, "잘못된 생년월일 양식입니다"));
			return "redirect:/survey/join";
		}
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(member.getName(), member.getPassword());
		token.setDetails(new WebAuthenticationDetails(request));
		return "redirect:/survey/main";
	}

	@RequestMapping("readSurvey")
	public String readSurvey(
			@RequestParam("survey_seq") int survey_seq, 
			@RequestParam("progressing") int progressing,
			Model model) throws Exception {
		boolean isProgressing = progressing == 1 ? true : false;
		SurveyVO surveyVo = null;
		if (isProgressing) {
			surveyVo = surveyService.getSurveyItems(survey_seq);
			model.addAttribute("survey", surveyVo);
			return "survey.readSurvey_on";
		}
		else {
			surveyVo = surveyService.getSurveyResult(survey_seq);
			ObjectMapper mapper = new ObjectMapper(); // create once, reuse
			String dataset = mapper.writeValueAsString(((SurveyWithDatasetVO)surveyVo).getDataset());
			List<SurveyItemVO> itemList = ((SurveyWithItemVO)surveyVo).getSurveyItemList();
			List<ReplyVO> replyList = surveyService.getReplyList(survey_seq);
			
			model.addAttribute("reply", replyList);
			model.addAttribute("survey", surveyVo);
			model.addAttribute("dataset", dataset);
			model.addAttribute("itemList", mapper.writeValueAsString(itemList));
			return "survey.readSurvey_off";
		}

	}

	//


	@RequestMapping(value="editProfile", method = RequestMethod.GET)
	public String editProfileGET() {
		return "survey.editProfile";
	}

	@RequestMapping(value="editProfile", method = RequestMethod.POST)
	public String editProfilePOST(@RequestParam("member") MemberVO member) {

		return "survey.index";
	}
	
	@RequestMapping(value = "replyInsert", method = RequestMethod.POST)
    public void insertReply(
    		@ModelAttribute("replyVO") ReplyVO replyVO, 
//			@RequestParam("reply_msg") String reply_msg, 
//			@RequestParam("survey_seq") int survey_seq, 
			Model model) {
		System.out.println("replyInsert called");
//		replyVO.setUsername(username);
//		replyVO.setReply_msg(reply_msg);
//		replyVO.setSurvey_seq(survey_seq);
		int result = surveyService.insertReply(replyVO);
		model.addAttribute("replyInsert", result);
    }
	
	
	//
	@RequestMapping(value="addSurvey",method = RequestMethod.GET)
	public String AddSurveyGET() throws Exception {
		System.out.println("...addSurveyGET...페이지 뿌려지는 함수");
		return "survey.addSurvey";
	}
	
	
	@RequestMapping(value="addSurvey", method = RequestMethod.POST)
	public String AddSurveyPOST(
												@RequestParam("title") String title, 
												@RequestParam("content") String content,
												@RequestParam("itemcontent") String itemcontent,
												@RequestParam("end_date") Date end_date,
												@RequestParam("image") MultipartFile multipartFile,							
												HttpServletRequest request,	Model model) throws Exception 
	{
		
		//int member_seq = (Integer) request.getSession().getAttribute("member_seq");
		SurveyVO svo = new SurveyVO();
		SurveyItemVO sivo = new SurveyItemVO();
		System.out.println(title);
		System.out.println(content);
		System.out.println(itemcontent);
		System.out.println(end_date);
		System.out.println(multipartFile);
		sivo.setContent(itemcontent);
		svo.setMember_seq(55555);
		svo.setTitle(title);
		svo.setContent(content);
		svo.setEnd_date(end_date);
		
		if (multipartFile!=null) {
				svo.setMimage(multipartFile);		
		}else if(multipartFile ==null) {
				svo.setImage("survey_default.jpg");
		}

		
		
		System.out.println("...addSurveyPOST...페이지 인서트...");
		surveyService.addSurvey(svo, sivo);
		model.addAttribute("result","success");
		return "redirect:/survey/index";
	}
	
	@RequestMapping("checkUsername") 
	public @ResponseBody Map<String, Object> checkUsername(
			@RequestParam("username") String username,
			Model model
			) throws Exception {
		Map<String, Object> return_param = new HashMap<>();
		String result = memberService.checkUsername(username);
		if (result == null || result.isEmpty()) {
			return_param.put("result", true);
			return_param.put("message", "사용 가능한 ID입니다.");
		}
		else {
			return_param.put("result", false);
			return_param.put("message", "사용 불가능한 ID입니다");
		} 
		return return_param;
	}
	
	//------------------------------------------------------------------------------admin
	//
	@RequestMapping(value="admin",method = RequestMethod.GET)
	public String adminGET() throws Exception {
		System.out.println("...adminGET...페이지 뿌려지는 함수");
		return "survey.admin";
	}
	
	
	
}
