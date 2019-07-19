package org.sist.project.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.mail.MessagingException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.sist.project.domain.Email;
import org.sist.project.domain.EmailSender;
import org.sist.project.domain.ErrorMessage;
import org.sist.project.domain.MemberVO;
import org.sist.project.domain.NoticeVO;
import org.sist.project.domain.PageMaker;
import org.sist.project.domain.ReplyVO;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SearchVO;
import org.sist.project.domain.SurveyItemVO;
import org.sist.project.domain.SurveyResultVO;
import org.sist.project.domain.SurveyVO;
import org.sist.project.domain.SurveyWithDatasetVO;
import org.sist.project.domain.SurveyWithItemVO;
import org.sist.project.domain.TempKey;
import org.sist.project.member.MemberDetails;
import org.sist.project.service.MemberService;
import org.sist.project.service.SurveyService;
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

	@Autowired
	MemberService memberService;
	@Autowired
	SurveyService surveyService;
	@Autowired
	EmailSender emailSender;
	@Autowired
	ServletContext c;
	
	private String realPath;
	
	@PostConstruct
	public void initController() {
		this.realPath = c.getRealPath("/resources/img");
	}

	
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
		} catch (IOException e) {
			rttr.addAttribute("errorMessage", new ErrorMessage(106, "사진 파일 저장이 실패했습니다."));
			return "redirect:/survey/join";
		} catch (SQLException e) {
			rttr.addAttribute("errorMessage", new ErrorMessage(107, "데이터 베이스에 문제가 생겼습니다."));
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
			@ModelAttribute("cri") SearchCriteria cri,
			Model model) throws Exception {
		boolean isProgressing = progressing == 1 ? true : false;
		SurveyVO surveyVo = null;
		if (isProgressing) {
			surveyVo = surveyService.getSurveyItems(survey_seq);
			List<ReplyVO> replyList = surveyService.getReplyList(survey_seq);
			model.addAttribute("survey", surveyVo);
			model.addAttribute("reply", replyList);

			return "survey.readSurvey_on";
		}
		else {
			surveyVo = surveyService.getSurveyResult(survey_seq);
			ObjectMapper mapper = new ObjectMapper(); // jackson, json 변환을 위한 객체. 
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
			@RequestParam(value="profileImage", required=false) MultipartFile multipartFile,
			@
			RequestParam("password") String password, 
			@RequestParam(value="changePassword", required=false) String changePassword, 
			@RequestParam("name") String name, 
			@RequestParam("birth") String birth, 
			@RequestParam("gender") String gender,
			@RequestParam("garbage") int garbage,
			HttpServletRequest request,
			RedirectAttributes rttr) throws Exception {
		// chagePassword가 null이라면 기존 비밀번호와 일치화시킴
		if (changePassword == null || changePassword.isEmpty()) {
			changePassword = password;
		}
		MemberDetails memberDetails = (MemberDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		MemberVO member = new MemberVO();
		String pattern = "yyyy/MM/dd";
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		
		Map<String, Object> return_param = new HashMap<>();

		try {
			member.setName(name);
			member.setGender(gender.equals("male") ? 1 : 0);
			member.setBirth(sdf.parse(birth));
			member.setUsername(memberDetails.getUsername());
			member.setImage(memberDetails.getImage());
			memberService.modifyMember(member, multipartFile, realPath, password, changePassword, garbage);
		} catch (IllegalArgumentException e) { // 이것도 확인 필요??
			return_param.put("result", false);
			return_param.put("message", "잘못된 생년월일 양식입니다");
			return return_param;
		} catch (BadCredentialsException e) {
			return_param.put("result", false);
			return_param.put("message", "비밀번호를 잘못 입력하셨습니다");
			return return_param;
		} catch (SQLException e) {
			return_param.put("result", false);
			return_param.put("message", "개인정보를 수정하지 못했습니다.");
			return return_param;
		} catch (IOException e) {
			return_param.put("result", false);
			return_param.put("message", "사진 변경에 실패하였습니다.");
			return return_param;
		}
		
		if(multipartFile != null)
			memberDetails.setImage(member.getImage());
		else if(multipartFile == null & garbage == 1)
			memberDetails.setImage(null);
		
		memberDetails.setName(name);
		memberDetails.setBirth(sdf.parse(birth));
		memberDetails.setGender(gender.equals("male") ? 1 : 0);

		return_param.put("result", true);
		return_param.put("message", "개인정보를 수정하였습니다.");
		return return_param;
	}
	
	@RequestMapping("quitMember")
	public @ResponseBody Map<String, Object> quitMember(
			@RequestParam("member_seq") int member_seq,
			@RequestParam("password") String password
			) throws Exception {
		
		Map<String, Object> return_param = new HashMap<>();
		try {
			memberService.removeMember(member_seq, password);
		} catch (BadCredentialsException e) {
			return_param.put("result", false);
			return_param.put("message", "비밀번호를 잘못 입력하셨습니다");
			return return_param;
		} catch (Exception e) {
			e.printStackTrace();
			return_param.put("result", false);
			return_param.put("message", "회원탈퇴에 실패했습니다.<br> 관리자에게 문의해주세요");
			return return_param;
		}
		return_param.put("result", true);
		return_param.put("message", "회원탈퇴가 성공하였습니다.");
		SecurityContextHolder.clearContext();
		return return_param;
	}
	
	@RequestMapping("closeSurvey")
	public String closeSurvey(@RequestParam("survey_seq") int survey_seq) {
		try {
			surveyService.closeSurvey(survey_seq);
		} catch (Exception e) {
			return "redirect:/survey/main?surveyclose=fail";
		}
		
		return "redirect:/survey/main?surveyclose=success";
	}
	
	@RequestMapping("removeSurvey")
	public String removeSurvey(@RequestParam("survey_seq") int survey_seq) {
		System.out.println("rem :" + survey_seq);
		try {
			surveyService.removeSurvey(survey_seq);
		} catch (Exception e) {
			return "redirect:/survey/main?surveyremove=fail";
		}
		
		return "redirect:/survey/main?surveyremove=success";
	}
	
	@RequestMapping(value = "replyInsert", method = RequestMethod.POST)
	public @ResponseBody boolean addReply(
			@ModelAttribute("replyVO") ReplyVO replyVO, 
			Model model) {
		int result = surveyService.insertReply(replyVO);
		model.addAttribute("replyInsert", result);
		return result>0?true:false;
	}
	@RequestMapping(value = "replyUpdate", method = RequestMethod.POST)
	public @ResponseBody boolean updateReply(
			@ModelAttribute("replyVO") ReplyVO replyVO, 
			Model model) {
		int result = surveyService.updateReply(replyVO);
		model.addAttribute("updateReply", result);
		return result>0?true:false;
	}
	@RequestMapping(value = "replyDel", method = RequestMethod.POST)
	public @ResponseBody boolean delReply(
			@ModelAttribute("replyVO") ReplyVO replyVO, 
			Model model) {
		int result = surveyService.delReply(replyVO);
		model.addAttribute("delReply", result);
		return result>0?true:false;
	}
	
	
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
			@RequestParam(value="image", required=false) MultipartFile multipartFile,							
			HttpServletRequest request,	Model model) throws Exception 
	{
		MemberDetails user = (MemberDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		SurveyVO svo = new SurveyVO(); 
		SurveyWithItemVO sivo = new SurveyWithItemVO();
		
		String pattern = "yyyy/MM/dd";
		String realPath = request.getRealPath("/resources/img");
		System.out.println(realPath);
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		svo.setRealPath(realPath);
		svo.setEnd_date(sdf.parse(end_date));
		svo.setTitle(title);
		svo.setContent(content);
		svo.setMimage(multipartFile);
		svo.setMember_seq(user.getMember_seq());
		List<SurveyItemVO> surveyItemList = new ArrayList<>();
		for (int i = 0; i < itemcontent.length; i++) {
			SurveyItemVO temp  = new SurveyItemVO();
			temp.setContent(itemcontent[i]);
			surveyItemList.add(temp);

		}
		sivo.setSurveyItemList(surveyItemList);
		surveyService.addSurvey(svo, sivo);
		
		return "redirect:/survey/main";
	}
	
	@RequestMapping(value="voteSurvey", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> addSurveyResult(
			@RequestParam("itemSeq") int itemSeq, 
			@RequestParam("survey_seq") int surveySeq) {
		MemberDetails user = (MemberDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		SurveyResultVO srvo = new SurveyResultVO();
		Map<String, Object> return_param = new HashMap<>();
		System.out.println("vote: " + itemSeq + "/" + surveySeq);
		try {
			srvo.setSurvey_item_seq(itemSeq);
			srvo.setMember_seq(user.getMember_seq());
			srvo.setSurvey_seq(surveySeq);
			surveyService.addSurveyResult(srvo);
			return_param.put("result", true);
			return_param.put("message", "설문에 참여하였습니다.");
		} catch (Exception e) {
			return_param.put("result", false);
			return_param.put("message", "이미 설문에 참여하였습니다.");
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

	@RequestMapping("checkUserNotice")
	public @ResponseBody Map<String, Object> checkUserNotify(
			@RequestParam("member_seq") int member_seq) throws Exception {
		Map<String, Object> ret = new HashMap<>();
		int result = memberService.getNoticeCount(member_seq);
		ret.put("result", result );
		return ret;
	}
	
	@RequestMapping("getUserNotice")
	public @ResponseBody List<NoticeVO> getUserNotice(
			@RequestParam("member_seq") int member_seq
			) throws Exception {
		
		List<NoticeVO> result = memberService.getUserNotice(member_seq);
		if(result!=null) memberService.readUserNotice(member_seq);
		return result;
	}
	
	
	//------------------------------------------------------------------------------admin

	@RequestMapping(value="admin",method = RequestMethod.GET)
	public String adminGET() throws Exception {
		return "survey.admin";
	}

	@RequestMapping("getSearchMember") 
	public @ResponseBody Model getSearchMember(
			@ModelAttribute("cri") SearchCriteria cri,
			@RequestParam("searchword_m") String searchWord,
			@RequestParam("searchoption_m") String searchOption,
			Model model
			) throws Exception {
			

	

	List<SurveyVO> surveyList = surveyService.getSurveyList(cri);
	model.addAttribute("surveyList", surveyList);

	PageMaker pageMaker = surveyService.getPagination(cri);
	model.addAttribute("pageMaker", pageMaker);

	List<MemberVO> adminList = memberService.getAdminList();
	model.addAttribute("adminList", adminList);
		
		
		
		
		List<MemberVO> searchResult= new ArrayList<>();
		SearchVO searchvo = new SearchVO();

		searchvo.setSearchOption(searchOption);
		searchvo.setSearchWord(searchWord);
		searchResult = memberService.getSearchMember(searchvo);
		model.addAttribute("searchResult", searchResult);
		//	return_param.put("list",searchResult);
		System.out.println("-------"+searchResult);

		return model;
	}
	@RequestMapping("getSearchSurvey") 
	public @ResponseBody List<SurveyVO> getSearchSurvey(
			@RequestParam("searchword_s") String searchWord,
			@RequestParam("searchoption_s") String searchOption,
			Model model
			) throws Exception {

		List<SurveyVO> searchResult= new ArrayList<>();
		SearchVO searchvo = new SearchVO();

		searchvo.setSearchOption(searchOption);
		searchvo.setSearchWord(searchWord);
		searchResult = surveyService.getSearchMember(searchvo);

		//	return_param.put("list",searchResult);
		System.out.println("-------"+searchResult);

		return searchResult;
	}

	@RequestMapping("modifyMemberUnabled") 
	public  @ResponseBody Map<Object, String> modifyMemberUnabled(
			@RequestParam("mem") String [] memlist) throws Exception {
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>도착");
		System.out.println(memlist.length);
		memberService.modifyMemberUnabled(memlist);
		Map<Object, String> message = new HashMap<>();

		message.put("message", "활동중지시켰네요^^");

		return message;
	}
	@RequestMapping("removeSurveyUnabled") 
	public  @ResponseBody Map<Object, String> removeSurveyUnabled(
			@RequestParam("surseq") String [] surseqlist) throws Exception {
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>도착");
		System.out.println(surseqlist.length);
		
		surveyService.removeSurveyUnabled(surseqlist);
		Map<Object, String> message = new HashMap<>();
		message.put("message", "게시물삭제성공^^");
		return message;
	}

}

