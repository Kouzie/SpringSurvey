package org.sist.project.controller;

import java.sql.SQLException;
import java.sql.SQLSyntaxErrorException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import org.sist.project.domain.Email;
import org.sist.project.domain.EmailSender;
import org.sist.project.domain.ErrorMessage;
import org.sist.project.domain.MemberVO;
import org.sist.project.domain.PageMaker;
import org.sist.project.domain.ReplyVO;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SurveyItemVO;
import org.sist.project.domain.SurveyResultVO;
import org.sist.project.domain.SurveyVO;
import org.sist.project.domain.SurveyWithDatasetVO;
import org.sist.project.domain.SurveyWithItemVO;
import org.sist.project.domain.TempKey;
import org.sist.project.member.MemberDetails;
import org.sist.project.service.MemberService;
import org.sist.project.service.SurveyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.mail.MailException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
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
	@Autowired
	EmailSender emailSender;
	
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
			@RequestParam("email") String email, 
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
		member.setEmail(email);
		member.setPassword(password);
		member.setName(name);
		member.setGender(gender.equals("male") ? 1 : 0);
		try {
			String pattern = "yyyy/MM/dd";
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
	
	@RequestMapping(value="foundPassword", method = RequestMethod.GET) 
	public String foundPasswordGET(Model model) throws Exception {
		return "survey.foundPassword";
	}
	@RequestMapping(value="foundPassword", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> foundPasswordPOST(
			@RequestParam("username") String username,
			@RequestParam("email") String email,
			Model model
			) throws Exception {
		Map<String, Object> return_param = new HashMap<>();
		boolean result = false;
		String message = "해당 아이디와 이메일이 일치하지 않습니다.";
		String userEmail = memberService.checkUserEmail(username);
		
		if (!userEmail.equals(email)) { //id와 email이 일치하지 않을경우
			return_param.put("result", result);
			return_param.put("message", message);
			return return_param;
		}
		try {
			String authKey = new TempKey().getKey(8, false);
			memberService.modifyPassword(username, authKey);
			Email email_obj = new Email();
			email_obj.setSubject("Springsubject 임시 비밀번호가 발송되었습니다.");
			email_obj.setContent("임시비밀번호 : " + authKey);
			email_obj.setReceiver(email);
			emailSender.SendEmail(email_obj);
		} 
		catch (SQLException e) {
			result = false;
			message = "임시비밀번호 변경이 실패했습니다.<br>다시 시도해주세요.";
			return_param.put("result", result);
			return_param.put("message", message);
			return return_param;
		}
		catch (MessagingException | MailException e) { //비밀번호 변경에 실패할 경우, 이메일 발송이 실패할 경우
			result = false;
			message = "메일 전송이 실패했습니다.<br>다시 시도해주세요.";
			return_param.put("result", result);
			return_param.put("message", message);
			return return_param;
		}
		
		
		result = true;
		message = "임시비밀번호를 메일로 발송하였습니다.";
		return_param.put("result", result);
		return_param.put("message", message);
		return return_param;
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

	@RequestMapping(value="editProfile", method = RequestMethod.GET)
	public String editProfileGET() {
		return "survey.editProfile";
	}

	@RequestMapping(value="editProfile", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> editProfilePOST(
			@RequestParam(value="image", required=false) MultipartFile multipartFile,
			@RequestParam("password") String password, 
			@RequestParam("changePassword") String changePassword, 
			@RequestParam("name") String name, 
			@RequestParam("birth") String birth, 
			@RequestParam("gender") String gender,
			@RequestParam("garbage") int garbage,
			HttpServletRequest request,
			RedirectAttributes rttr) throws Exception {
			MemberDetails user = (MemberDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
			String realPath = request.getRealPath("/resources/img");
			MemberVO member = new MemberVO();
			Map<String, Object> return_param = new HashMap<>();
			String pattern = "yyyy-MM-dd";
			SimpleDateFormat sdf = new SimpleDateFormat(pattern);
			logger.info("con: " + password + "/" + changePassword + "/" + name + "/" + birth + "/" + gender + "/" + multipartFile + "/" + garbage);
			member.setName(name);
			member.setGender(gender.equals("male") ? 1 : 0);
			try {
				
				member.setBirth(sdf.parse(birth));
				member.setUsername(user.getUsername());
				boolean result = memberService.updateMember(member, multipartFile, realPath, password, changePassword, garbage);
				
				if(result == false) {
					return_param.put("result", false);
					return_param.put("message", "개인정보를 수정하지 못했습니다.");
				}
				else {
					return_param.put("result", true);
					return_param.put("message", "개인정보를 수정하였습니다.");
				}
			} catch (IllegalArgumentException e) { // 이것도 확인 필요??
				return_param.put("result", false);
				return_param.put("message", "잘못된 생년월일 양식입니다");
				return return_param;
			} catch (BadCredentialsException e) {
				return_param.put("result", false);
				return_param.put("message", "비밀번호를 잘못 입력하셨습니다");
				logger.info(password);
				return return_param;
			}
			
			user.setName(name);
			user.setBirth(sdf.parse(birth));
			user.setGender(gender.equals("male") ? 1 : 0);
			
			if(multipartFile != null)
				user.setImage(multipartFile.getOriginalFilename());
			else if(multipartFile == null & garbage == 1)
				user.setImage(null);
				
		return return_param;
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
		return "survey.addSurvey";
	}
	
	
	@RequestMapping(value="addSurvey", method = RequestMethod.POST)
	public String AddSurveyPOST(
		@RequestParam("title") String title, 
		@RequestParam("content") String content,
		@RequestParam("itemcontent") String [] itemcontent,
		@RequestParam("end_date") String end_date,
		@RequestParam("image") MultipartFile multipartFile,							
		HttpServletRequest request,	Model model) throws Exception 
	{
		MemberDetails user = (MemberDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		SurveyVO svo = new SurveyVO(); 
		SurveyWithItemVO sivo = new SurveyWithItemVO();
		String pattern = "yyyy/MM/dd";
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		svo.setEnd_date(sdf.parse(end_date));
		svo.setMember_seq(user.getMember_seq());
		svo.setTitle(title);
		svo.setContent(content);

		List<SurveyItemVO> surveyItemList = new ArrayList<>();
		for (int i = 0; i < itemcontent.length; i++) {
			SurveyItemVO temp  = new SurveyItemVO();
			temp.setContent(itemcontent[i]);
			surveyItemList.add(temp);
			
		}
	
		sivo.setSurveyItemList(surveyItemList);
		if (multipartFile!=null) {
				svo.setMimage(multipartFile);		
		}else if(multipartFile ==null) {
				svo.setImage("survey_default.jpg");
		}
		surveyService.addSurvey(svo, sivo);
		return "redirect:/survey/main";
	}
	
	@RequestMapping(value="readSurvey_on", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertSurveyResult(@RequestParam("itemSeq") int itemSeq, @RequestParam("surveySeq") int surveySeq) {
		MemberDetails user = (MemberDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		SurveyResultVO srvo = new SurveyResultVO();
		Map<String, Object> return_param = new HashMap<>();
		
		try {
			srvo.setSurvey_item_seq(itemSeq);
			srvo.setMember_seq(user.getMember_seq());
			srvo.setSurvey_seq(surveySeq);
			surveyService.insertSurveyResult(srvo);
			return_param.put("result", true);
			return_param.put("message", "설문에 참여하였습니다.");
		} catch (Exception e) {
			return_param.put("result", false);
			return_param.put("message", "이미 설문에 참여하셨습니다.");
			return return_param;
		}
		
		return return_param;
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
			return_param.put("message", "중복된 불가능한 ID입니다");
		} 
		return return_param;
	}
	
	//------------------------------------------------------------------------------admin
	
	@RequestMapping(value="admin",method = RequestMethod.GET)
	public String adminGET() throws Exception {
		System.out.println("...adminGET...페이지 뿌려지는 함수");
		return "survey.admin";
	}
	
	
	
}
