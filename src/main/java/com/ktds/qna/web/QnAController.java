package com.ktds.qna.web;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ktds.common.session.Session;
import com.ktds.common.util.DownloadUtil;
import com.ktds.member.vo.MemberVO;
import com.ktds.qna.service.QnAService;
import com.ktds.qna.vo.QnAVO;
import com.nhncorp.lucy.security.xss.XssFilter;

import io.github.seccoding.web.mimetype.ExtFilter;
import io.github.seccoding.web.mimetype.ExtensionFilter;
import io.github.seccoding.web.mimetype.ExtensionFilterFactory;

@Controller
public class QnAController {
	
	@Value("${upload.path}")
	private String uploadPath;
	
	@Autowired
	private QnAService qnaService;
	
	@GetMapping("/qna/write")
	public String viewWriteQnAPage() {
		
		return "qna/write";
	}
	
	@PostMapping("/qna/write")
	public ModelAndView doWriteQnAAction(@Valid@ModelAttribute QnAVO qnaVO
										  , Errors errors
										  , @SessionAttribute(Session.CSRF_TOKEN) String sessionToken
										  , @SessionAttribute(Session.USER) MemberVO memberVO
										  ) {
		
		ModelAndView view = new ModelAndView("redirect:/concert/list");
		
		if ( !qnaVO.getToken().equals(sessionToken) ) {
			throw new RuntimeException("잘못된 접근입니다.");
		}
		
		if ( errors.hasErrors() ) {
			for (FieldError error : errors.getFieldErrors()) {
				String errorMessage =  error.getDefaultMessage();
			}
			
			view.setViewName("concert/list");
			view.addObject("qnaVO", qnaVO);
			
			return view;
		}
		
		System.out.println(qnaVO.getSubject());
		System.out.println(qnaVO.getContent());
		
		qnaVO.setMemberVO(memberVO);
		qnaVO.setEmail(memberVO.getEmail());
		
		System.out.println(qnaVO.getEmail());
		
		XssFilter filter = XssFilter.getInstance("lucy-xss-superset.xml");
		qnaVO.setSubject(filter.doFilter(qnaVO.getSubject()));
		qnaVO.setContent(filter.doFilter(qnaVO.getContent()));
		
		boolean isWriteSuccess = this.qnaService.createOneQnA(qnaVO);
		
		return view;
	}
	
	@PostMapping("/qna/imageUpload")
	@ResponseBody
	public Map<String, Object> doImageUploadAction(MultipartHttpServletRequest multiFile) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		MultipartFile uploadFile = multiFile.getFile("upload");
		
		if ( !uploadFile.isEmpty() ) {
						
			String fileName = UUID.randomUUID().toString();
			
			File uploadDir = new File(this.uploadPath);
			
			if ( !uploadDir.exists() ) {
				uploadDir.mkdirs();
			}
			
			File destFile = new File(this.uploadPath, fileName);
			
			try {
				uploadFile.transferTo(destFile);
			}
			catch ( IllegalStateException | IOException e ) {
				throw new RuntimeException(e.getMessage(), e);
			}
			finally {
				if ( destFile.exists() ) {
					ExtensionFilter filter = ExtensionFilterFactory.getFilter(ExtFilter.APACHE_TIKA);
					boolean isImageFile = filter.doFilter(destFile.getAbsolutePath()
														   , "image/bmp"
														   , "image/png"
														   , "image/jpg"
														   , "image/jpeg"
														   , "image/gif");
							
					if ( !isImageFile ) {
						destFile.delete();
					}
					
					result.put("url", "/AdvanceBooking/qna/imageDownload/" + fileName);
				}
			}
		}
		
		result.put("uploaded", true);
		
		System.out.println(uploadFile);
		
		return result;
	}
	
	@RequestMapping("/qna/imageDownload/{fileName}")
	public void doImageDownloadAction(@PathVariable String fileName
									   , HttpServletRequest request
									   , HttpServletResponse response) {
		try {
			new DownloadUtil(this.uploadPath + File.separator + fileName)
				.download(request, response, fileName);
			
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e.getMessage(),e);
		} 
	}
	
	@RequestMapping("/qna/detail/{id}")
	public ModelAndView viewQnADetailPage(@PathVariable String id
										  , @RequestParam String token
										  , @SessionAttribute(Session.CSRF_TOKEN) String sessionToken) {
		
		ModelAndView view = new ModelAndView("qna/detail");
		
		QnAVO qnaVO = this.qnaService.readOneQnA(id);
		
		qnaVO.setToken(token);
		
		if ( !qnaVO.getToken().equals(sessionToken) ) {
			throw new RuntimeException("잘못된 접근입니다.");
		}
		
		view.addObject("qnaVO", qnaVO);
		
		return view;
	}
	
	@RequestMapping("/qna/list")
	public ModelAndView viewQnAListPage() {
		
		ModelAndView view = new ModelAndView("qna/list");
		
		// csrf token check
		
		List<QnAVO> qnaVOList = this.qnaService.readAllQnAs();
		
		view.addObject("qnaVOList", qnaVOList);
		
		return view;
	}
	
	@RequestMapping("/qna/delete/{id}")
	public String doDeleteQnAAction(@PathVariable String id
									, @SessionAttribute(Session.CSRF_TOKEN)String sessionToken
									, @RequestParam String token
									) {
		
		if ( !sessionToken.equals(token) ) {
			throw new RuntimeException("잘못된 접근입니다.");
		}
		
		boolean isDelete = this.qnaService.deleteOneQnA(id);
		
		return "redirect:/qna/list";
	}
}
