package com.ktds.concert.prefer.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ktds.common.session.Session;
import com.ktds.concert.prefer.service.PreferService;
import com.ktds.concert.prefer.vo.PreferVO;

@Controller
public class PreferController {
	
	@Autowired
	private PreferService preferService;
	
	@PostMapping("concert/prefer/regist/{concertId}")
	@ResponseBody
	public Map<String, Object> doRegistPreferAction(@PathVariable String concertId
										, @SessionAttribute(Session.CSRF_TOKEN) String sessionToken
										, @ModelAttribute PreferVO preferVO) {
		
		if ( !sessionToken.equals( preferVO.getToken() ) ) {
			System.out.println(preferVO.getToken());
			
			System.out.println(preferVO.getConcertId());
			
			System.out.println(preferVO.getEmail());
			
			System.out.println(sessionToken);
			throw new RuntimeException("잘못된 인증");
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("status", "OK");
		
		boolean isRegistSuccess = this.preferService.registOnePrefer(preferVO);
		
		if ( isRegistSuccess ) {
			result.put("isRegistSuccess", isRegistSuccess);
		}
		return result;
	}
	
}
